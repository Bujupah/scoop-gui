class Application {
  final String name;
  final String version;
  final String bucket;
  final bool installed;
  Application({
    this.name, 
    this.version = 'N/A',
    this.bucket = 'N/A',
    this.installed = false
  });
}