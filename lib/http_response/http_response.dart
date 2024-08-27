class ResquestResponse{
  final int statuscode;
  final String message;
  final bool success;
//  final String body;
  ResquestResponse(this.statuscode, this.message, this.success);
}