package br.dojo.transitive.dependencies;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class DependencyParser {

	private DependencyFactory<String> dependencyFactory;

	// I could use a dependency injection framework here.
	// But this would be unnecessary complexity.
	public DependencyParser(DependencyFactory<String> dependencyFactory) {
		this.dependencyFactory = dependencyFactory;
	}

	public List<Dependency<String>> parse(String string) {
		List<Dependency<String>> dependencies;

		dependencies = new ArrayList<>();

		for (String line : string.split("\n")) {
			dependencies.add(parseLine(line));
		}

		return dependencies;
	}

	private Dependency<String> parseLine(String line) {
		Dependency<String> dependency;
		List<String> descriptions;

		// Crap, Java! Why are your APIs so hard on programmers?
		// http://stackoverflow.com/questions/1624144/unsupportedoperationexception-for-tarray-aslist-removeint
		descriptions = new ArrayList<>(Arrays.asList(line.split("\\s+")));

		dependency = dependencyFactory.build(descriptions.remove(0));

		for (String description : descriptions) {
			dependency.addDependency(dependencyFactory.build(description));
		}

		return dependency;
	}
}
