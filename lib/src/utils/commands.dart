const List<String> GET_SCOOP = ["Invoke-Expression", "(New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')"];


extension Scoop on String {
  String get install => 'install $this'; 
  String get uninstall => 'uninstall $this'; 
  String get search => 'search $this';
  String get bucket => 'bucket add $this';
}

extension exitCode on int {
  bool get isFine => (this ?? 1) == 0 ? true : false; 
}