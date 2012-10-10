package transitive_dependencies.transitive_dependencies;

import static org.junit.Assert.assertEquals;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.junit.Test;

public class MainTest {

    @Test
    public void testCaseOfProblemDescription() {

        String expectedString = "A B C E F G H\n" + "B C E F G H\n" + "C G\n"
                + "D A B C E F G H\n" + "E F H\n" + "F H";

        String actualString = "A B C\n" + "B C E\n" + "C G\n" + "D A F\n"
                + "E F\n" + "F H";

        DependencyParser expectedDependencyParser = new DependencyParser(
                new DependencyFactory<String>());
        DependencyParser actualDependencyParser = new DependencyParser(
                new DependencyFactory<String>());

        DependencyResolver<String> dependencyResolver = new DependencyResolver<>();

        Map<Dependency<String>, Set<Dependency<String>>> expected = new HashMap<>();

        for (Dependency<String> dependency : expectedDependencyParser
                .parse(expectedString)) {
            expected.put(dependency, dependency.getDependencies());
        }

        assertEquals(expected,
                dependencyResolver.resolve(actualDependencyParser
                        .parse(actualString)));
    }

}
