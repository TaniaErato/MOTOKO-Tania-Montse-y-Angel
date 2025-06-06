import Array "mo:base/Array";

actor Database {
    type Animal = {
        ID : Nat;
        Especie : Text;
        Nombre : Text;
        Condicion : Text;
    };
    var animals : [Animal] = [];

    public func addAnimal(ID : Nat, Especie : Text, Nombre : Text, Condicion : Text) : async Bool {
        let newAnimal = {
            ID = ID;
            Especie = Especie;
            Nombre = Nombre;
            Condicion = Condicion;
        };
        animals := Array.append<Animal>(animals, [newAnimal]);
        return true;
    };

    public func getAllAnimals() : async [Animal] {
        return animals;
    };

    public func getAnimalByID(ID : Nat) : async ?Animal {
        return Array.find<Animal>(animals, func(animal) { animal.ID == ID });
    };

    public func updateAnimal(ID : Nat, Especie : Text, Nombre : Text, Condicion : Text) : async Bool {
        let animalToUpdate = Array.find<Animal>(animals, func(animal) { animal.ID == ID });

        switch (animalToUpdate) {
            case (null) { return false };
            case (?animalToUpdate) {
                let updatedAnimal = {
                    ID = ID;
                    Especie = Especie;
                    Nombre = Nombre;
                    Condicion = Condicion;
                };
                animals := Array.map<Animal, Animal>(animals, func(animal) {
                    if (animal.ID == ID) { updatedAnimal } 
                    else { animal }
                });
                return true;
            };
        };
    };

    public func deleteAnimal(ID : Nat) : async Bool {
        let animal = Array.find<Animal>(animals, func(animal) { animal.ID == ID });
        if (animal != null) {
            animals := Array.filter<Animal>(animals, func(animal) { animal.ID != ID });
            return true;
        } else { 
            return false;
        }; 
    };
};