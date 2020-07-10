
class Meal {
  final String ATPT_OFCDC_SC_CODE;
  final String ATPT_OFCDC_SC_NM;
  final String SD_SCHUL_CODE;
  final String SCHUL_NM;
  final String MMEAL_SC_CODE;
  final String MMEAL_SC_NM;
  final String MLSV_YMD;
  final int MLSV_FGR;
  final String DDISH_NM;

  Meal(
      {this.ATPT_OFCDC_SC_CODE,
      this.ATPT_OFCDC_SC_NM,
      this.SD_SCHUL_CODE,
      this.SCHUL_NM,
      this.MMEAL_SC_CODE,
      this.MMEAL_SC_NM,
      this.MLSV_YMD,
      this.MLSV_FGR,
      this.DDISH_NM
    });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      ATPT_OFCDC_SC_CODE: json['ATPT_OFCDC_SC_CODE'],
      ATPT_OFCDC_SC_NM: json['ATPT_OFCDC_SC_NM'],
      SD_SCHUL_CODE: json['SD_SCHUL_CODE'],
      SCHUL_NM: json['SCHUL_NM'],
      MMEAL_SC_CODE: json['MMEAL_SC_CODE'],
      MMEAL_SC_NM: json['MMEAL_SC_NM'],
      MLSV_YMD: json['MLSV_YMD'],
      MLSV_FGR: json['MLSV_FGR'],
      DDISH_NM: json['DDISH_NM'],
    );
  }
}