#' Predicting Cardiovascular disease risk based systolic/diastolic blood pressure
#'
#' @param gender A binary variable taking 1 if patient is female and 0 if male
#' @param age A number for age
#' @param Tchol A number for total serum cholesterol in mg/dL measured by the Abell-Kendall method
#' @param HDLchol A number for high-density lipoprotein (HDL) Cholesterol in mg/dL
#' @param SBP A number fo systolic blood pressure in mm Hg
#' @param DBP A number for diastolic blood pressure in mm Hg
#' @param diabetes A binary variable taking 1 if the patient was under treatment with insulin or oral hypoglycemic agents, if casual blood glucose determinations exceeded 140 mg/dL
#' @param smoker A binary variable taking 1 for person who smoked during the past 12 month and 0 therwise
#' @param ECG_LVH A binary variable taking 1 for patients diagnosed with ECG-left ventricular hypertrophy and 0 otherwise (If there is no information, it is 0)
#' @param t A number for time until CVD from the beginning of follow-up
#'
#' @examples
#'
#' @source \url{https://www.ahajournals.org/doi/pdf/10.1161/01.CIR.83.1.356} and \url{https://www.sciencedirect.com/science/article/pii/000287039190861B}

predictCVD <- function (gender, age, Tchol, HDLchol, SBP, DBP, diabetes, smoker, ECG_LVH, t) {


  #============================================================= SBP prediction =====================================================================================

  m_CHD_s = 15.5305 + 28.4441 * gender - 1.4792 * log (age) - 0 * log (age ^ 2) - 14.4588 * log (age) * gender + 1.8515 * log (age) ^ 2 * gender - 0.9119 * log (SBP)
            - 0.2767 * smoker - 0.7181 * log (Tchol / HDLchol) - 0.1759 * diabetes - 0.1999 * diabetes * gender - 0.5865 * ECG_LVH - 0 * ECG_LVH * (1- gender)

  m_MI_s = 11.4712 + 10.51 * gender - 0.7965 * log (age) - 0 * log (age ^ 2) - 5.4216 * log (age) * gender + 0.7101 * log (age) ^ 2 * gender - 0.6623 * log (SBP)
  - 0.2675 * smoker - 0.4277 * log (Tchol / HDLchol) - 0.1534 * diabetes - 0.1165 * diabetes * gender - 0 * ECG_LVH - 0.1588 * ECG_LVH * (1- gender)

  m_CHDdeath_s =  11.2889 + 0.2332 * gender - 0.9440 * log (age) - 0 * log (age ^ 2) - 0 * log (age) * gender + 0 * log (age) ^ 2 * gender - 0.5880 * log (SBP)
  - 0.1367 * smoker - 0.3448 * log (Tchol / HDLchol) - 0.0474 * diabetes - 0.2233 * diabetes * gender - 0.1237 * ECG_LVH - 0 * ECG_LVH * (1- gender)

  m_stroke_s = 26.5116 + 0.2019 * gender - 2.3741 * log (age) - 0 * log (age ^ 2) - 0 * log (age) * gender + 0 * log (age) ^ 2 * gender - 2.4643 * log (SBP)
  - 0.3914 * smoker - 0.0229 * log (Tchol / HDLchol) - 0.3087 * diabetes - 0.2627 * diabetes * gender - 0.2355 * ECG_LVH - 0 * ECG_LVH * (1- gender)

  m_CVD_s = 18.8144  - 1.2146 * gender - 1.8443 * log (age) - 0 * log (age ^ 2) + 0.3668 * log (age) * gender + 0 * log (age) ^ 2 * gender - 1.4032 * log (SBP)
  - 0.3899 * smoker - 0.5390 * log (Tchol / HDLchol) - 0.3036 * diabetes - 0.1697 * diabetes * gender - 0.3362 * ECG_LVH - 0 * ECG_LVH * (1- gender)

  m_CVDdeath_s = -5.0385  + 0.2243 * gender + 8.2370 * log (age) - 1.2109 * log (age ^ 2) - 0 * log (age) * gender + 0 * log (age) ^ 2 * gender - 0.8383 * log (SBP)
  - 0.1618 * smoker - 0.3493 * log (Tchol / HDLchol) - 0.0833 * diabetes - 0.2067 * diabetes * gender - 0.2946 * ECG_LVH - 0 * ECG_LVH * (1- gender)


  log_sigma_CHD_s = 0.9145 - 0.2784 * m_CHD_s

  log_sigma_MI_s = 3.4064 - 0.8584 * m_MI_s

  log_sigma_CHDdeath_s = 2.9851 - 0.9142 * m_CHDdeath_s

  log_sigma_stroke_s = - 0.4312 - 0 * m_stroke_s

  log_sigma_CVD_s = 0.6536 - 0.2402 * m_CVD_s

  log_sigma_CVDdeath_s = 0.8207 - 0.4346 * m_CVDdeath_s



  sigma_CHD_s = exp (log_sigma_CHD_s)

  sigma_MI_s = exp (log_sigma_MI_s)

  sigma_CHDdeath_s = exp (log_sigma_CHDdeath_s)

  sigma_stroke_s = exp (log_sigma_stroke_s)

  sigma_CVD_s = exp (log_sigma_CVD_s)

  sigma_CVDdeath_s = exp (log_sigma_CVDdeath_s)


  u_CHD_s = (log(t) - m_CHD_s) / sigma_CHD_s

  u_MI_s = (log(t) - m_MI_s) / sigma_MI_s

  u_CHDdeath_s = (log(t) - m_CHDdeath_s) / sigma_CHDdeath_s

  u_stroke_s = (log(t) - m_stroke_s) / sigma_stroke_s

  u_CVD_s = (log(t) - m_CVD_s) / sigma_CVD_s

  u_CVDdeath_s = (log(t) - m_CVDdeath_s) / sigma_CVDdeath_s


  p_CHD_s = 1 - exp(-exp(u_CHD_s))

  p_MI_s = 1 - exp(-exp(u_MI_s))

  p_CHDdeath_s = 1 - exp(-exp(u_CHDdeath_s))

  p_stroke_s = 1 - exp(-exp(u_stroke_s))

  p_CVD_s = 1 - exp(-exp(u_CVD_s))

  p_CVDdeath_s = 1 - exp(-exp(u_CVDdeath_s))

  #============================================================= DBP prediction =====================================================================================


  m_CHD_d = 15.5222 + 32.4811 * gender - 1.6347 * log (age) - 0 * log (age ^ 2) - 16.4933 * log (age) * gender + 2.1059 * log (age) ^ 2 * gender - 0.8670 * log (DBP)
  - 0.2789 * smoker - 0.7142 * log (Tchol / HDLchol) - 0.2082 * diabetes - 0.1973 * diabetes * gender - 0.7195 * ECG_LVH - 0 * ECG_LVH * (1- gender)

  m_MI_d = 11.0436 + 5.1559 * gender - 0.9302 * log (age) - 0 * log (age ^ 2) - 2.6310 * log (age) * gender + 0.3472 * log (age) ^ 2 * gender - 0.5132 * log (DBP)
  - 0.2721 * smoker - 0.4228 * log (Tchol / HDLchol) - 0.1764 * diabetes - 0.1184 * diabetes * gender - 0 * ECG_LVH - 0.1702 * ECG_LVH * (1- gender)

  m_CHDdeath_d =  12.0963 + 0.2619 * gender - 1.3025 * log (age) - 0 * log (age ^ 2) - 0 * log (age) * gender + 0 * log (age) ^ 2 * gender - 0.4762 * log (DBP)
  - 0.1553 * smoker - 0.4056 * log (Tchol / HDLchol) - 0.0860 * diabetes - 0.2539 * diabetes * gender - 0.1591 * ECG_LVH - 0 * ECG_LVH * (1- gender)

  m_stroke_d = 25.1067 + 0.1558 * gender - 3.0997 * log (age) - 0 * log (age ^ 2) - 0 * log (age) * gender + 0 * log (age) ^ 2 * gender - 1.7556 * log (DBP)
  - 0.3975 * smoker - 0.0297 * log (Tchol / HDLchol) - 0.4047 * diabetes - 0.2506 * diabetes * gender - 0.2801 * ECG_LVH - 0 * ECG_LVH * (1- gender)

  m_CVD_d = 17.5392  - 0.8019 * gender - 2.1231 * log (age) - 0 * log (age ^ 2) + 0.2584 * log (age) * gender + 0 * log (age) ^ 2 * gender - 1.0117 * log (DBP)
  - 0.3900 * smoker - 0.5365 * log (Tchol / HDLchol) - 0.30575 * diabetes - 0.1661 * diabetes * gender - 0.3847 * ECG_LVH - 0 * ECG_LVH * (1- gender)

  m_CVDdeath_d = - 9.0211  + 0.2102 * gender + 9.5223 * log (age) - 1.3999 * log (age ^ 2) - 0 * log (age) * gender + 0 * log (age) ^ 2 * gender - 0.5073 * log (DBP)
  - 0.1548 * smoker - 0.3423 * log (Tchol / HDLchol) - 0.1178 * diabetes - 0.1982 * diabetes * gender - 0.3181 * ECG_LVH - 0 * ECG_LVH * (1- gender)


  log_sigma_CHD_d = 0.9341 - 0.2825 * m_CHD_d

  log_sigma_MI_d = 3.4587 - 0.8647 * m_MI_d

  log_sigma_CHDdeath_d = 2.1249 - 0.6860 * m_CHDdeath_d

  log_sigma_stroke_d = - 0.4212 - 0 * m_stroke_d

  log_sigma_CVD_d = 0.6761 - 0.2421 * m_CVD_d

  log_sigma_CVDdeath_d = 0.9076 - 0.4528 * m_CVDdeath_d



  sigma_CHD_d = exp (log_sigma_CHD_d)

  sigma_MI_d = exp (log_sigma_MI_d)

  sigma_CHDdeath_d = exp (log_sigma_CHDdeath_d)

  sigma_stroke_d = exp (log_sigma_stroke_d)

  sigma_CVD_d = exp (log_sigma_CVD_d)

  sigma_CVDdeath_d = exp (log_sigma_CVDdeath_d)


  u_CHD_d = (log(t) - m_CHD_d) / sigma_CHD_d

  u_MI_d = (log(t) - m_MI_d) / sigma_MI_d

  u_CHDdeath_d = (log(t) - m_CHDdeath_d) / sigma_CHDdeath_d

  u_stroke_d = (log(t) - m_stroke_d) / sigma_stroke_d

  u_CVD_d = (log(t) - m_CVD_d) / sigma_CVD_d

  u_CVDdeath_d = (log(t) - m_CVDdeath_d) / sigma_CVDdeath_d


  p_CHD_d = 1 - exp(-exp(u_CHD_d))

  p_MI_d = 1 - exp(-exp(u_MI_d))

  p_CHDdeath_d = 1 - exp(-exp(u_CHDdeath_d))

  p_stroke_d = 1 - exp(-exp(u_stroke_d))

  p_CVD_d = 1 - exp(-exp(u_CVD_d))

  p_CVDdeath_d = 1 - exp(-exp(u_CVDdeath_d))



  }

