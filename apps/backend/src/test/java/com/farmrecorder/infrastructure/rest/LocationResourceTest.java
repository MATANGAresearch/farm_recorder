package com.farmrecorder.infrastructure.rest;

import io.quarkus.test.junit.QuarkusTest;
import io.quarkus.test.security.TestSecurity;
import io.restassured.http.ContentType;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.*;

@QuarkusTest
class LocationResourceTest {

    @Test
    @TestSecurity(user = "farmuser", roles = {"FARM_WORKER"})
    void testCreateLocation() {
        String uniqueGln = String.valueOf(1000000000000L + (long) (Math.random() * 8999999999999L));
        String locationJson = String.format("""
                {
                    "gln": "%s",
                    "name": "Test Field Unique",
                    "type": "FIELD",
                    "geoJsonPolygon": "{\\"type\\":\\"Polygon\\",\\"coordinates\\":[[[35.0,32.0],[35.1,32.0],[35.1,32.1],[35.0,32.1],[35.0,32.0]]]}"
                }
                """, uniqueGln);

        given()
                .contentType(ContentType.JSON)
                .body(locationJson)
                .when().post("/api/v1/locations")
                .then()
                .statusCode(201)
                .body("name", equalTo("Test Field Unique"))
                .body("gln", equalTo(uniqueGln))
                .body("type", equalTo("FIELD"))
                .body("id", notNullValue());
    }

    @Test
    @TestSecurity(user = "farmuser", roles = {"FARM_WORKER"})
    void testGetAllLocations() {
        given()
                .contentType(ContentType.JSON)
                .when().get("/api/v1/locations")
                .then()
                .statusCode(200);
    }
}
