class Application {
  final String name;
  final String logo;
  final String version;
  final String website;
  final String description;
  final List<String> tags;
  final Map<String, String> alternative;

  Application({
    this.name, 
    this.logo, 
    this.version = 'N/A', 
    this.website = 'N/A', 
    this.description = 'No description',
    this.tags = const[], 
    this.alternative = const{}
  });
}