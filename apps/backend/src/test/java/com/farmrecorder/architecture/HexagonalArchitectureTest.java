package com.farmrecorder.architecture;

import com.tngtech.archunit.core.importer.ImportOption;
import com.tngtech.archunit.junit.AnalyzeClasses;
import com.tngtech.archunit.junit.ArchTest;
import com.tngtech.archunit.lang.ArchRule;

import static com.tngtech.archunit.library.Architectures.layeredArchitecture;

@AnalyzeClasses(packages = "com.farmrecorder", importOptions = ImportOption.DoNotIncludeTests.class)
public class HexagonalArchitectureTest {

    @ArchTest
    public static final ArchRule hexagonalArchitectureRule = layeredArchitecture()
            .consideringOnlyDependenciesInAnyPackage("com.farmrecorder..")
            .layer("Domain").definedBy("com.farmrecorder.domain..")
            .layer("Application").definedBy("com.farmrecorder.application..")
            .layer("Infrastructure").definedBy("com.farmrecorder.infrastructure..")

            .whereLayer("Domain").mayOnlyBeAccessedByLayers("Application", "Infrastructure")
            .whereLayer("Application").mayOnlyBeAccessedByLayers("Infrastructure")
            .whereLayer("Infrastructure").mayNotBeAccessedByAnyLayer();
}
