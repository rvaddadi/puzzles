package transitive_dependencies.transitive_dependencies;

import static org.junit.Assert.assertEquals;

import java.util.HashSet;
import java.util.Set;

import org.junit.Before;
import org.junit.Test;

public class DependencyFactoryTest {

    private DependencyFactory<String> dependencyFactory;

    @Before
    public void setUp() {

        dependencyFactory = new DependencyFactory<String>();
    }

    @Test
    public void testCanCreateDependency() {

        assertEquals(new Dependency<String>("A"), dependencyFactory.build("A"));
    }

    @Test
    public void testAlwaysReturnSameDependency() throws Exception {

        assertEquals(dependencyFactory.build("A"), dependencyFactory.build("A"));
    }

    @Test
    public void testMaintainDependencyList() throws Exception {

        Set<Dependency<String>> expected = new HashSet<>();

        Dependency<String> dependencyA = dependencyFactory.build("A");
        Dependency<String> dependencyB = dependencyFactory.build("B");

        expected.add(dependencyB);

        dependencyA.addDependency(dependencyB);

        assertEquals(expected, dependencyFactory.build("A").getDependencies());
    }
}
