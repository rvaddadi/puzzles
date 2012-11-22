var mammal = {
  name:     '',
  get_name: function() { return this.name; }
};

var cat = Object.create(mammal);

cat.name = 'cat';

console.log(cat.get_name());
