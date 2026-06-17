package com.farmrecorder.infrastructure.rest;

import io.quarkus.test.junit.QuarkusTest;
import io.quarkus.test.security.TestSecurity;
import io.restassured.http.ContentType;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.*;

@QuarkusTest
class InputBatchResourceTest {

    @Test
    @TestSecurity(user = "admin", roles = {"ADMIN"})
    void testRegisterAndLookupInputBatch() {
        UUID productId = UUID.randomUUID();
        UUID batchId = UUID.randomUUID();
        String gtin = "00871234567890";
        String lotNumber = "LOT-RESOURCE-TEST-" + UUID.randomUUID().toString().substring(0, 8);

        String batchJson = String.format("""
                {
                    "id": "%s",
                    "gtin": "%s",
                    "lotNumber": "%s",
                    "productId": "%s",
                    "initialQuantity": 150.00,
                    "remainingQuantity": 150.00,
                    "expirationDate": "%s",
                    "unit": "Liters"
                }
                """, batchId, gtin, lotNumber, productId, Instant.now().plusSeconds(86400 * 30).toString());

        // 1. Register input batch (admin only)
        given()
                .contentType(ContentType.JSON)
                .body(batchJson)
                .when().post("/api/v1/input-batches")
                .then()
                .statusCode(201)
                .body("gtin", equalTo(gtin))
                .body("lotNumber", equalTo(lotNumber))
                .body("remainingQuantity", equalTo(150.0f));

        // 2. Lookup input batch (available to WORKER/ADMIN)
        given()
                .contentType(ContentType.JSON)
                .queryParam("gtin", gtin)
                .queryParam("lotNumber", lotNumber)
                .when().get("/api/v1/input-batches/lookup")
                .then()
                .statusCode(200)
                .body("id", equalTo(batchId.toString()))
                .body("remainingQuantity", equalTo(150.0f));
    }

    @Test
    @TestSecurity(user = "farmuser", roles = {"FARM_WORKER"})
    void testRegisterInputBatch_ForbiddenForWorker() {
        String batchJson = """
                {
                    "id": "019ecc19-b6be-76d9-b997-5e89f6c0e35b",
                    "gtin": "12345",
                    "lotNumber": "LOT-1",
                    "productId": "019ecc19-b6be-76d9-b997-5e89f6c0e35c",
                    "initialQuantity": 10.0,
                    "remainingQuantity": 10.0,
                    "expirationDate": "2026-12-31T00:00:00Z",
                    "unit": "Liters"
                }
                """;

        given()
                .contentType(ContentType.JSON)
                .body(batchJson)
                .when().post("/api/v1/input-batches")
                .then()
                .statusCode(403);
    }
}
