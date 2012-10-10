package transitive_dependencies.transitive_dependencies;

import static org.junit.Assert.assertEquals;

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
}
