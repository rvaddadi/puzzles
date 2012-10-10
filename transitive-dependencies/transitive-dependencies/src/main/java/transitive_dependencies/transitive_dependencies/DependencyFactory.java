package transitive_dependencies.transitive_dependencies;

import java.util.HashMap;
import java.util.Map;

public class DependencyFactory<T> {

    private Map<T, Dependency<T>> instances;

    public DependencyFactory() {

        instances = new HashMap<>();
    }

    public Dependency<T> build(T description) {

        Dependency<T> dependency;

        dependency = instances.get(description);

        if (dependency == null) {
            dependency = new Dependency<T>(description);
            instances.put(description, dependency);
        }

        return dependency;
    }
}
