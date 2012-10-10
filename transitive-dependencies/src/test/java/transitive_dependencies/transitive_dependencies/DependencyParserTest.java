package transitive_dependencies.transitive_dependencies;

import static org.junit.Assert.assertEquals;

import java.util.HashSet;
import java.util.Set;

import org.junit.Before;
import org.junit.Test;

public class DependencyParserTest {

    private DependencyParser          dependencyParser;
    private DependencyFactory<String> dependencyFactory;

    @Before
    public void setUp() {

        // Maybe it would be best to mock the factory.
        // But this is very arguable.
        dependencyFactory = new DependencyFactory<>();
        dependencyParser = new DependencyParser(dependencyFactory);
    }

    @Test
    public void testSimpleDependency() {

        Set<Dependency<String>> expected = new HashSet<>();

        Dependency<String> dependencyA = dependencyFactory.build("A");
        Dependency<String> dependencyB = dependencyFactory.build("B");

        dependencyA.addDependency(dependencyB);

        expected.add(dependencyA);

        assertEquals(expected, dependencyParser.parse("A B"));
    }

    @Test
    public void testDoubleDependency() {

        Set<Dependency<String>> expected = new HashSet<>();

        Dependency<String> dependencyA = dependencyFactory.build("A");
        Dependency<String> dependencyB = dependencyFactory.build("B");
        Dependency<String> dependencyC = dependencyFactory.build("C");

        dependencyA.addDependency(dependencyB);
        dependencyA.addDependency(dependencyC);

        expected.add(dependencyA);

        assertEquals(expected, dependencyParser.parse("A B C"));
    }

    @Test
    public void testMultipleLine() {

        Set<Dependency<String>> expected = new HashSet<>();

        Dependency<String> dependencyA = dependencyFactory.build("A");
        Dependency<String> dependencyB = dependencyFactory.build("B");
        Dependency<String> dependencyC = dependencyFactory.build("C");
        Dependency<String> dependencyD = dependencyFactory.build("D");

        dependencyA.addDependency(dependencyB);
        dependencyC.addDependency(dependencyD);

        expected.add(dependencyA);
        expected.add(dependencyC);

        assertEquals(expected, dependencyParser.parse("A B\nC D"));
    }

}
