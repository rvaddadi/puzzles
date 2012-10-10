package transitive_dependencies.transitive_dependencies;

import static org.junit.Assert.assertEquals;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.junit.Before;
import org.junit.Test;

public class DependencyResolverTest {

    DependencyResolver<String> dependencyResolver;
    DependencyFactory<String>  dependencyFactory;

    @Before
    public void setUp() {

        dependencyFactory = new DependencyFactory<>();
        dependencyResolver = new DependencyResolver<>();
    }

    @Test
    public void testSimpleDependency() {

        Set<Dependency<String>> expected = new HashSet<>();

        Dependency<String> dependencyA = dependencyFactory.build("A");
        Dependency<String> dependencyB = dependencyFactory.build("B");

        dependencyA.addDependency(dependencyB);

        expected.add(dependencyB);

        assertEquals(expected, dependencyResolver.resolve(dependencyA));
    }

    @Test
    public void testMultipleDependencies() {

        Set<Dependency<String>> subject = new HashSet<>();

        Map<Dependency<String>, Set<Dependency<String>>> expected = new HashMap<>();
        Set<Dependency<String>> lineExpectedA;
        Set<Dependency<String>> lineExpectedC;

        Dependency<String> dependencyA = dependencyFactory.build("A");
        Dependency<String> dependencyB = dependencyFactory.build("B");
        Dependency<String> dependencyC = dependencyFactory.build("C");
        Dependency<String> dependencyD = dependencyFactory.build("D");

        dependencyA.addDependency(dependencyB);
        dependencyC.addDependency(dependencyD);

        lineExpectedA = new HashSet<>();
        lineExpectedA.add(dependencyB);

        lineExpectedC = new HashSet<>();
        lineExpectedC.add(dependencyD);

        expected.put(dependencyA, lineExpectedA);
        expected.put(dependencyC, lineExpectedC);

        subject.add(dependencyA);
        subject.add(dependencyC);

        assertEquals(expected, dependencyResolver.resolve(subject));
    }

    @Test
    public void testSimpleTransitiveDependency() {

        Set<Dependency<String>> expected = new HashSet<>();

        Dependency<String> dependencyA = dependencyFactory.build("A");
        Dependency<String> dependencyB = dependencyFactory.build("B");
        Dependency<String> dependencyC = dependencyFactory.build("C");

        dependencyA.addDependency(dependencyB);
        dependencyB.addDependency(dependencyC);

        expected.add(dependencyB);
        expected.add(dependencyC);

        assertEquals(expected, dependencyResolver.resolve(dependencyA));
    }

    @Test
    public void testDeepTransitiveDependency() {

        Set<Dependency<String>> expected = new HashSet<>();

        Dependency<String> dependencyA = dependencyFactory.build("A");
        Dependency<String> dependencyB = dependencyFactory.build("B");
        Dependency<String> dependencyC = dependencyFactory.build("C");
        Dependency<String> dependencyD = dependencyFactory.build("D");

        dependencyA.addDependency(dependencyB);
        dependencyB.addDependency(dependencyC);
        dependencyC.addDependency(dependencyD);

        expected.add(dependencyB);
        expected.add(dependencyC);
        expected.add(dependencyD);

        assertEquals(expected, dependencyResolver.resolve(dependencyA));
    }

    @Test
    public void testCyclicDependency() {

        Set<Dependency<String>> expected = new HashSet<>();

        Dependency<String> dependencyA = dependencyFactory.build("A");
        Dependency<String> dependencyB = dependencyFactory.build("B");
        Dependency<String> dependencyC = dependencyFactory.build("C");

        dependencyA.addDependency(dependencyB);
        dependencyB.addDependency(dependencyC);
        dependencyC.addDependency(dependencyA);

        expected.add(dependencyB);
        expected.add(dependencyC);

        assertEquals(expected, dependencyResolver.resolve(dependencyA));
    }
}
