package com.farmrecorder.infrastructure.opensearch;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;
import jakarta.inject.Singleton;
import org.apache.hc.core5.http.HttpHost;
import org.opensearch.client.json.jackson.JacksonJsonpMapper;
import org.opensearch.client.opensearch.OpenSearchClient;
import org.opensearch.client.transport.OpenSearchTransport;
import org.opensearch.client.transport.httpclient5.ApacheHttpClient5TransportBuilder;

@ApplicationScoped
public class OpenSearchProducer {

    @Produces
    @Singleton
    public OpenSearchClient produceOpenSearchClient() {
        final HttpHost host = new HttpHost("http", "localhost", 9200);

        final OpenSearchTransport transport = ApacheHttpClient5TransportBuilder
                .builder(host)
                .setMapper(new JacksonJsonpMapper())
                .build();

        return new OpenSearchClient(transport);
    }
}
