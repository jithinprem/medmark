import 'package:flutter/material.dart';

class AddPatientData{
    final String patient_id;
    final String fullname;
    final String painval;
    final String tiredness;
    final String drowsiness;
    final String lack_aptitite;
    final String shortness_breath;
    final String depression;
    final String anxiety;
    final String nausea;
    final String wellbeing;
    final String additional_comment;

    AddPatientData({
        required this.patient_id,
        required this.fullname,
        required this.painval,
        required this.tiredness,
        required this.drowsiness,
        required this.lack_aptitite,
        required this.shortness_breath,
        required this.depression,
        required this.anxiety,
        required this.nausea,
        required this.wellbeing,
        required this.additional_comment
    });

    toJson() {
        return {
            'patient_id': patient_id,
            'fullname': fullname,
            'painal': painval,
            'tiredness': tiredness,
            'drowsiness': drowsiness,
            'lack_aptitite': lack_aptitite,
            'shortness_breath': shortness_breath,
            'depressioin': depression,
            'anxiety': anxiety,
            'nausea': nausea,
            'wellbeing': wellbeing,
            'additional_comment': additional_comment
        };
    }

}

