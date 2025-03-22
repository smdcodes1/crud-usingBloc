class Item {
    
    String id;
    String name;
    String description;

    Item({
        required this.name,
        required this.id,
        required this.description,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json["name"],
        id: json["id"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "description": description,
    };
}