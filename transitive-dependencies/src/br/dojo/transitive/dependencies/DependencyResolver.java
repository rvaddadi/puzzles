package br.dojo.transitive.dependencies;

public class DependencyResolver<T> {

	@SuppressWarnings("unused")
	private DependencyFactory<T> dependencyFactory;

	public DependencyResolver(DependencyFactory<T> dependencyFactory) {
		this.dependencyFactory = dependencyFactory;
	}
}
