package transitive_dependencies.transitive_dependencies;

import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Set;

public class DependencyResolver<T> {

    @SuppressWarnings("unused")
    private DependencyFactory<T> dependencyFactory;

    public DependencyResolver(DependencyFactory<T> dependencyFactory) {

        this.dependencyFactory = dependencyFactory;
    }

    public Map<Dependency<T>, Set<Dependency<T>>> resolve(
            List<Dependency<T>> dependencies) {

        Map<Dependency<T>, Set<Dependency<T>>> result = new HashMap<>();

        for (Dependency<T> dependency : dependencies) {
            result.put(dependency, resolve(dependency));
        }

        return result;
    }

    public Set<Dependency<T>> resolve(Dependency<T> dependency) {

        Queue<Dependency<T>> queue;
        Set<Dependency<T>> visited;
        Dependency<T> currentDependency;

        queue = new LinkedList<>();
        visited = new HashSet<>();

        queue.add(dependency);

        while (!queue.isEmpty()) {
            currentDependency = queue.remove();

            if (!visited.contains(currentDependency)) {
                visited.add(currentDependency);
                queue.addAll(currentDependency.getDependencies());
            }
        }

        visited.remove(dependency);

        return visited;
    }
}
