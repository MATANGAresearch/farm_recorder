package com.farmrecorder.infrastructure.epcis;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.farmrecorder.domain.model.ActivityLog;
import com.farmrecorder.domain.port.EpcisGatewayPort;
import com.farmrecorder.domain.port.ProductRepositoryPort;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.jboss.logging.Logger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ApplicationScoped
public class EpcisGatewayAdapter implements EpcisGatewayPort {

    private static final Logger LOG = Logger.getLogger(EpcisGatewayAdapter.class);
    private final Client client;
    private final String epcisUrl;
    private final ObjectMapper mapper = new ObjectMapper();
    private final ProductRepositoryPort productRepository;

    @Inject
    public EpcisGatewayAdapter(ProductRepositoryPort productRepository) {
        this.productRepository = productRepository;
        this.client = ClientBuilder.newClient();
        // Default to local OpenEPCIS container (or mock if not available)
        this.epcisUrl = System.getenv().getOrDefault("EPcis_URL", "http://localhost:8081/epcis/");
    }

    @Override
    public void publishEvent(ActivityLog activityLog) {
        try {
            Map<String, Object> event;
            if (activityLog.type().name().equals("DIRECT_SALE")) {
                event = buildEpcisTransactionEvent(activityLog);
            } else {
                event = buildEpcisObjectEvent(activityLog);
            }
            
            String jsonPayload = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(event);

            // Log the generated GS1 EPCIS 2.0 compliant payload for validation
            LOG.infof("=== EPCIS Event Generated for ActivityLog %s ===\n%s\n==========================================",
                activityLog.id(), jsonPayload);

            Response response = client.target(epcisUrl + "events")
                .request(MediaType.APPLICATION_JSON)
                .post(Entity.json(event));

            if (response.getStatusInfo().getFamily() == Response.Status.Family.SUCCESSFUL) {
                LOG.infof("Successfully published EPCIS event to %s", epcisUrl);
            } else {
                LOG.warnf("EPCIS server returned %d: %s (Running in mock/validation mode if server is down)",
                    response.getStatus(), response.readEntity(String.class));
            }
        } catch (Exception e) {
            // Expected if OpenEPCIS is not running locally. The JSON payload is still logged above for validation.
            LOG.infof("EPCIS server unreachable at %s. Payload was generated and logged above for validation.", epcisUrl);
        }
    }

    private Map<String, Object> buildEpcisObjectEvent(ActivityLog log) {
        Map<String, Object> event = new HashMap<>();
        event.put("type", "ObjectEvent");
        event.put("eventTime", log.timestamp().toString());
        event.put("eventTimeZoneOffset", "+02:00"); 

        Map<String, Object> bizStep = new HashMap<>();
        bizStep.put("type", "urn:epcglobal:cbv:bizstep:" + log.type().name().toLowerCase());
        event.put("bizStep", bizStep);

        Map<String, Object> disposition = new HashMap<>();
        disposition.put("type", "urn:epcglobal:cbv:disp:in_progress");
        event.put("disposition", disposition);

        // Read Point (Location GLN)
        Map<String, Object> readPoint = new HashMap<>();
        // Simplified GLN mapping: urn:epc:id:sgln:<company_prefix>.<location_reference>.<check_digit>
        readPoint.put("id", "urn:epc:id:sgln:0614141." + log.locationId().toString().replace("-", "").substring(0, 12) + ".0");
        event.put("readPoint", readPoint);

        // Extension for GPS and Notes (Custom EPCIS 2.0 extension for GAP compliance)
        Map<String, Object> extension = new HashMap<>();
        extension.put("gpsLat", log.gpsLat());
        extension.put("gpsLng", log.gpsLng());
        extension.put("gapNotes", log.notes());
        event.put("extension", extension);

        // EPC List: Generate proper GS1 SGTIN URI if a product is linked to this activity
        List<String> epcList = new ArrayList<>();
        if (log.productId() != null) {
            productRepository.findById(log.productId()).ifPresent(product -> {
                // Simplified SGTIN generation: urn:epc:id:sgtin:<company_prefix>.<item_reference>.<serial>
                // Using a dummy company prefix and the product's GTIN as item reference for demonstration
                String sgtin = String.format("urn:epc:id:sgtin:0614141.%s.0", product.gtin().substring(1));
                epcList.add(sgtin);
            });
        }
        event.put("epcList", epcList);

        return event;
    }

    private Map<String, Object> buildEpcisTransactionEvent(ActivityLog log) {
        Map<String, Object> event = new HashMap<>();
        event.put("type", "TransactionEvent");
        event.put("eventTime", log.timestamp().toString());
        event.put("eventTimeZoneOffset", "+02:00");

        Map<String, Object> bizStep = new HashMap<>();
        bizStep.put("type", "urn:epcglobal:cbv:bizstep:shipping"); // Or 'selling' if custom vocabulary is used
        event.put("bizStep", bizStep);

        Map<String, Object> disposition = new HashMap<>();
        disposition.put("type", "urn:epcglobal:cbv:disp:in_transit");
        event.put("disposition", disposition);

        // Read Point (Farm Gate GLN)
        Map<String, Object> readPoint = new HashMap<>();
        readPoint.put("id", "urn:epc:id:sgln:0614141." + log.locationId().toString().replace("-", "").substring(0, 12) + ".0");
        event.put("readPoint", readPoint);

        // Extension for customer and sale details
        Map<String, Object> extension = new HashMap<>();
        extension.put("customerName", log.customerName());
        extension.put("customerPhone", log.customerPhone());
        extension.put("customerEmail", log.customerEmail());
        extension.put("quantity", log.quantity());
        extension.put("totalPrice", log.totalPrice());
        event.put("extension", extension);

        // EPC List: Link to the specific Harvest Batch
        List<String> epcList = new ArrayList<>();
        if (log.batchId() != null) {
            // Simplified mapping: urn:epc:id:sgtin:<company_prefix>.<batch_id>.0
            epcList.add("urn:epc:id:sgtin:0614141." + log.batchId().toString().replace("-", "").substring(0, 12) + ".0");
        }
        event.put("epcList", epcList);

        return event;
    }
}
