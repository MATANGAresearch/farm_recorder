package com.farmrecorder.infrastructure.rest;

import io.quarkus.test.junit.QuarkusTest;
import io.quarkus.test.security.TestSecurity;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.*;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

@QuarkusTest
class ProductResourceValidationTest {

    @Test
    @TestSecurity(user = "adminuser", roles = {"ADMIN"})
    void testCreateProduct_ValidationFails() {
        String invalidProductJson = """
                {
                    "gtin": "invalid-gtin",
                    "name": "",
                    "type": ""
                }
                """;

        Response response = given()
                .contentType(ContentType.JSON)
                .body(invalidProductJson)
                .when()
                .post("/api/v1/products")
                .then()
                .statusCode(400)
                .contentType(ContentType.JSON)
                .body("title", equalTo("Validation Failed"))
                .body("status", equalTo(400))
                .body("detail", notNullValue())
                .body("instance", equalTo("/api/v1/products"))
                .body("correlationId", notNullValue())
                .body("violations", notNullValue())
                .extract().response();

        String correlationIdHeader = response.getHeader("X-Correlation-ID");
        assertNotNull(correlationIdHeader);
        assertTrue(correlationIdHeader.length() > 0);

        String mdcCorrelationId = response.jsonPath().getString("correlationId");
        assertTrue(correlationIdHeader.equals(mdcCorrelationId));
    }
}
