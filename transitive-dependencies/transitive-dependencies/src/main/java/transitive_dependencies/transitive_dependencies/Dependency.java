package transitive_dependencies.transitive_dependencies;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class Dependency<T> {

    private T                  description;
    private Set<Dependency<T>> dependencies;

    /**
     * You probably shouldn't be calling this constructor yourself. Look at
     * {@link DependencyFactory}.
     */
    public Dependency(T description) {

        this.description = description;
        this.dependencies = new HashSet<>();
    }

    public boolean addDependency(Dependency<T> dependency) {

        return dependencies.add(dependency);
    }

    @Override
    public String toString() {

        return description.toString();
    }

    @Override
    public int hashCode() {

        final int prime = 31;
        int result = 1;
        result = prime * result
                + ((description == null) ? 0 : description.hashCode());
        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public boolean equals(Object obj) {

        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Dependency other = (Dependency) obj;
        if (description == null) {
            if (other.description != null)
                return false;
        } else if (!description.equals(other.description))
            return false;
        return true;
    }

    public T getDescription() {

        return description;
    }

    public Set<Dependency<T>> getDependencies() {

        return Collections.unmodifiableSet(dependencies);
    }
}
