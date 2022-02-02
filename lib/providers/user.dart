class User {
  int id;
  String name;
  String email;
  String createdAt;
  String updatedAt;
  String dhUltimoAcesso;
  String dashboardConfig;
  int empresaId;
  String restoreId;

  User(
      {this.id,
      this.name,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.dhUltimoAcesso,
      this.dashboardConfig,
      this.empresaId,
      this.restoreId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dhUltimoAcesso = json['dhUltimoAcesso'];
    dashboardConfig = json['dashboard_config'];
    empresaId = json['empresa_id'];
    restoreId = json['restoreId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['dhUltimoAcesso'] = this.dhUltimoAcesso;
    data['dashboard_config'] = this.dashboardConfig;
    data['empresa_id'] = this.empresaId;
    data['restoreId'] = this.restoreId;
    return data;
  }
}
