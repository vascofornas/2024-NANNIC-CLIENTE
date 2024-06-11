class PacienteDatosConsentimientos {
  final String? id;
  final String? id_paciente;
  final String? informed_consent;
  final String? privacy_policy;
  final String? consent_scientific_research;
  final String? consent_commercial_purposes;
  final String? statement_honor_no_symtoms_abnormalities;
  final String? firma_consent;
  final String? firma_statement_honor;
  final String? firma_scientific_research;
  final String? firma_commercial_purposes;
  final String? fecha_firmas;
  final String? observaciones_consentimientos;



  PacienteDatosConsentimientos({
    this.id,
    this.id_paciente,
    this.informed_consent,
    this.privacy_policy,
    this.consent_scientific_research,
    this.consent_commercial_purposes,
    this.statement_honor_no_symtoms_abnormalities,
    this.firma_consent,
    this.firma_statement_honor,
    this.firma_scientific_research,
    this.firma_commercial_purposes,
    this.fecha_firmas,
    this.observaciones_consentimientos

  });

  factory PacienteDatosConsentimientos.fromJson(Map<String, dynamic> json) {
    return PacienteDatosConsentimientos(
      id: json['id'] != null ? json['id'] as String : null,
      id_paciente: json['id_paciente'] != null ? json['id_paciente'] as String : null,
      informed_consent: json['informed_consent'] != null ? json['informed_consent'] as String : null,
      consent_scientific_research: json['consent_scientific_research'] != null ? json['consent_scientific_research'] as String : null,
      consent_commercial_purposes: json['consent_commercial_purposes'] != null ? json['consent_commercial_purposes'] as String : null,
      statement_honor_no_symtoms_abnormalities: json['statement_honor_no_symtoms_abnormalities'] != null ? json['statement_honor_no_symtoms_abnormalities'] as String : null,
      firma_consent: json['firma_consent'] != null ? json['firma_consent'] as String : null,
      firma_scientific_research: json['firma_scientific_research'] != null ? json['firma_scientific_research'] as String : null,
      firma_commercial_purposes: json['firma_commercial_purposes'] != null ? json['firma_commercial_purposes'] as String : null,
      firma_statement_honor: json['firma_statement_honor'] != null ? json['firma_statement_honor'] as String : null,
      observaciones_consentimientos: json['observaciones_consentimientos'] != null ? json['observaciones_consentimientos'] as String : null,
      fecha_firmas: json['fecha_firmas'] != null && json['fecha_firmas'] != '0000-00-00'
          ? json['fecha_firmas'] as String
          : 'Fecha no disponible', // O cualquier otro valor predeterminado que desees usar
    );
  }

}



