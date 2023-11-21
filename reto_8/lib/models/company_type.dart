enum CompanyType{
  consulting,
  software,
}

extension ToString on CompanyType{
  String get name{
    switch(this){
      case CompanyType.consulting:
        return 'Consultoría';
      case CompanyType.software:
        return 'Software';
      default:
        return 'Unknown';
    }
  }
}