class ConsentTexts {
  static String informedConsent(String patientName, String therapistName) {
    return """
    

    I, $patientName, acknowledge that I have been informed by $therapistName about the nature of the proposed physiotherapy treatment. This treatment includes, but is not limited to, manual techniques, therapeutic exercises, and physical modalities such as heat, cold, ultrasound, and electrotherapy.

    ### Risks and Benefits
    I have been informed of the possible benefits and risks of the treatment, which may include, but are not limited to, pain relief, improved mobility, and reduced inflammation. I also understand that there is a risk of temporary discomfort, pain, or exacerbation of symptoms.

    ### Alternatives
    I have been explained the alternatives to the proposed treatment, including the option of not receiving treatment.

    ### Questions and Clarifications
    I have had the opportunity to ask questions about the treatment, and my questions have been answered satisfactorily.

    ### Consent
    By signing below, I give my consent to proceed with the treatment as described.

    
    """;
  }

  static String privacyPolicy(String clinica) {
    return """
    Privacy Policy

    At $clinica, we are committed to protecting your privacy. This Privacy Policy outlines how we collect, use, and protect your personal information.

    ### Information Collection
    We collect personal information such as your name, contact details, medical history, and treatment records.

    ### Use of Information
    Your information is used to provide and manage your healthcare services, communicate with you, and comply with legal obligations.

    ### Protection of Information
    We implement various security measures to protect your personal information from unauthorized access, alteration, disclosure, or destruction.

    ### Consent
    By signing below, you acknowledge that you have read and understood our Privacy Policy.

    
    """;
  }

  static String consentForScientificResearch() {
    return """
    Consent for Scientific Research

    I, ______________________ (patient's name), give my consent for my medical data to be used for scientific research purposes. I understand that my personal information will be anonymized to protect my identity.

    ### Purpose of Research
    The purpose of this research is to improve medical treatments and outcomes for future patients.

    ### Confidentiality
    All data will be kept confidential and used in accordance with applicable laws and regulations.

    ### Voluntary Participation
    Participation in this research is voluntary, and I can withdraw my consent at any time without affecting my treatment.

    **Patient's Signature:** ___________________________ **Date:** _______________
    """;
  }

  static String consentForCommercialPurposes() {
    return """
    Consent for Commercial Purposes

    I, ______________________ (patient's name), give my consent for my medical data to be used for commercial purposes, including marketing and product development. I understand that my personal information will be anonymized to protect my identity.

    ### Purpose
    The purpose of using this data is to improve our products and services and to inform patients about relevant offerings.

    ### Confidentiality
    All data will be kept confidential and used in accordance with applicable laws and regulations.

    ### Voluntary Participation
    Participation is voluntary, and I can withdraw my consent at any time without affecting my treatment.

    **Patient's Signature:** ___________________________ **Date:** _______________
    """;
  }

  static String statementOnHonorOfNoSymptoms(String patientName) {
    return """
    Statement on Honor of No Symptoms/Abnormalities

    I, $patientName, hereby declare on my honor that, to the best of my knowledge, I am not experiencing any symptoms or abnormalities that could affect my physiotherapy treatment.

    ### Health Status
    I affirm that I have disclosed all relevant health information to my therapist and will inform them of any changes in my condition.

    ### Acknowledgment
    I understand that this declaration is important for ensuring my safety during treatment.

    **Patient's Signature:** ___________________________ **Date:** _______________
    """;
  }
}
