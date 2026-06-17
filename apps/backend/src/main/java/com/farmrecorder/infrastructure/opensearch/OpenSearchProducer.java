package com.farmrecorder.infrastructure.opensearch;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;
import jakarta.inject.Singleton;
import org.apache.http.HttpHost;
import org.opensearch.client.RestClient;
import org.opensearch.client.json.jackson.JacksonJsonpMapper;
import org.opensearch.client.opensearch.OpenSearchClient;
import org.opensearch.client.transport.rest_client.RestClientTransport;

@ApplicationScoped
public class OpenSearchProducer {

    @Produces
    @Singleton
    public OpenSearchClient produceOpenSearchClient() {
        final RestClient restClient = RestClient.builder(
                new HttpHost("localhost", 9200, "http")).build();

        final RestClientTransport transport = new RestClientTransport(
                restClient, new JacksonJsonpMapper());

        return new OpenSearchClient(transport);
    }
}
