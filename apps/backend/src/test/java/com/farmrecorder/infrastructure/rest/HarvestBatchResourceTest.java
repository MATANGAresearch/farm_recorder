package com.farmrecorder.infrastructure.rest;

import io.quarkus.test.junit.QuarkusTest;
import io.quarkus.test.security.TestSecurity;
import io.restassured.http.ContentType;
import org.junit.jupiter.api.Test;

import java.util.UUID;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.*;

@QuarkusTest
class HarvestBatchResourceTest {

    @Test
    @TestSecurity(user = "farmuser", roles = {"FARM_WORKER"})
    void testGetAvailableBatchesByProductId() {
        UUID productId = UUID.randomUUID();
        
        given()
                .contentType(ContentType.JSON)
                .when().get("/api/v1/harvest-batches/available/" + productId)
                .then()
                .statusCode(200);
    }
}
