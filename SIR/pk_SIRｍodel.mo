package pk_SIRmodel
  class cl_SIRsimple
    extends Modelica.Blocks.Icons.Block;
    parameter Real contact_rate = 0.5 / 1000 "Infectious rate (1/day)";
    parameter Real gamma_const = 0.2 "Recovery rate (1/day)";
    Modelica.Blocks.Interfaces.RealInput Si "Connector of initial S(Susceptible)" annotation(
      Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Ii "Connector of initial I (Infectious)" annotation(
      Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Ri "Connector of initial R (Removed)" annotation(
      Placement(visible = true, transformation(origin = {-100, -62}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Sy "Output connector of S(Susceptible)" annotation(
      Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Iy "Output connector of I (Infectious)" annotation(
      Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Ry "Output connector of R (Removed)" annotation(
      Placement(visible = true, transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  initial equation
    Sy = Si;
    Iy = Ii;
    Ry = Ri;
  equation
    der(Sy) = -contact_rate * Sy * Iy;
    der(Iy) = contact_rate * Sy * Iy - Iy * gamma_const;
    der(Ry) = Iy * gamma_const;
    annotation(
      Icon(graphics = {Text(origin = {-14, 11}, extent = {{-56, 33}, {78, -51}}, textString = "SIR")}));
  end cl_SIRsimple;

  class cl_SIRbetaInput
    extends Modelica.Blocks.Icons.Block;
      //  parameter Real contact_rate = 0.2/1000 "The infectious rate (1/day)";
      parameter Real gamma_const = 0.2 "The Recovery rate (1/day)";
      Modelica.Blocks.Interfaces.RealInput Si "Connector of initial S(Susceptible)" annotation(
        Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Ii "Connector of initial I(Infectious)" annotation(
        Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput Ri "Connector of initial R(Removed)" annotation(
        Placement(visible = true, transformation(origin = {-100, -62}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Sy "Output connector of S(Susceptible)" annotation(
        Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Iy "Output connector of I(Infectious)" annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput Ry "Output connector of R(Removed)" annotation(
        Placement(visible = true, transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput contact_rate "Connector of infectious rate" annotation(
        Placement(visible = true, transformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
      Modelica.Blocks.Interfaces.RealOutput Inew "Output connector of New I(Infectious)" annotation(
        Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    initial equation
      Sy = Si;
      Iy = Ii;
      Ry = Ri;
    equation
      der(Sy) = -contact_rate * Sy * Iy;
      der(Iy) = contact_rate * Sy * Iy - Iy * gamma_const;
      der(Ry) = Iy * gamma_const;
      Inew = -der(Sy);
      annotation(
        Icon(graphics = {Text(origin = {-14, 11}, extent = {{-56, 33}, {78, -51}}, textString = "SIR")}, coordinateSystem(initialScale = 0.1)));
  end cl_SIRbetaInput;

class cl_SIRreinfect
    extends Modelica.Blocks.Icons.Block;
    parameter Real gamma_const = 0.2 "Recovery rate (1/day)";
    parameter Real reinfect_rate = 0.001 "Reinfection rate";
    parameter Real dying_rate = 0.01 "Dying rate";
    Modelica.Blocks.Interfaces.RealInput Si "Connector of initial S(Susceptible)" annotation(
      Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Ii "Connector of initial I (Infectious)" annotation(
      Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Ri "Connector of initial R (Removed)" annotation(
      Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Sy "Output connector of S(Susceptible)" annotation(
      Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Iy "Output connector of I (Infectious)" annotation(
      Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Ry "Output connector of R (Removed)" annotation(
      Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput contact_rate "Connector of infectious rate" annotation(
      Placement(visible = true, transformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput Inew "Output connector of New I(Infectious)" annotation(
      Placement(visible = true, transformation(origin = {-60, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {-60, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput Rlive "Output connector of R (Live)" annotation(
      Placement(visible = true, transformation(origin = {60, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {60, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Blocks.Interfaces.RealOutput Rdead "Output connector of R (Dead)" annotation(
      Placement(visible = true, transformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  initial equation
    Sy = Si;
    Iy = Ii;
    Ry = Ri;
  equation
    der(Sy) = (-contact_rate * Sy * Iy) + Rlive * reinfect_rate;
    der(Iy) = contact_rate * Sy * Iy - Iy * gamma_const;
    der(Ry) = Iy * gamma_const - Ry * reinfect_rate;
    Inew = -der(Sy);
    der(Rdead) = Iy * gamma_const * dying_rate;
    Rlive = Ry - Rdead;
annotation(
      Diagram,
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {-62, 53}, extent = {{-52, 29}, {174, -133}}, textString = "SIR\nReI")}));end cl_SIRreinfect;

  class cl_Vaccine
    extends Modelica.Blocks.Icons.Block;
    parameter Real vaccine_effect = 1.0 "Effect of Vaccine";
    parameter Real vaccine_rate = 0.7 "Vaccination rate";
    Modelica.Blocks.Interfaces.RealInput Si "Connector of initial S(Susceptible)" annotation(
        Placement(visible = true, transformation(origin = {-100, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Ii "Connector of initial I (Infectious)" annotation(
        Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput Ri "Connector of initial R (Removed)" annotation(
        Placement(visible = true, transformation(origin = {-100, -62}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Sy "Output connector of S(Susceptible)" annotation(
        Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Iy "Output connector of I (Infectious)" annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Ry "Output connector of R (Removed)" annotation(
        Placement(visible = true, transformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput Vy "Output connector of Vaccination rate" annotation(
        Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = -90), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      Vy = vaccine_effect * vaccine_rate;
      Sy = Si - Si * Vy;
      Iy = Ii;
      Ry = Ri + Si * Vy;
    annotation(
        Icon(graphics = {Text(origin = {-22, 24}, extent = {{-52, 32}, {94, -72}}, textString = "Vac")}, coordinateSystem(initialScale = 0.1)));
  end cl_Vaccine;

  model mdl_SIRsample
    pk_SIRmodel.cl_SIRsimple cl_SIRsimple1 annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant Si(k = 999) annotation(
      Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant Ii(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant Ri(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-70, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Si.y, cl_SIRsimple1.Si) annotation(
      Line(points = {{-59, 40}, {-30, 40}, {-30, 6}, {-10, 6}}, color = {0, 0, 127}));
    connect(Ii.y, cl_SIRsimple1.Ii) annotation(
      Line(points = {{-58, 0}, {-12, 0}, {-12, 0}, {-10, 0}}, color = {0, 0, 127}));
    connect(Ri.y, cl_SIRsimple1.Ri) annotation(
      Line(points = {{-59, -40}, {-30, -40}, {-30, -6}, {-10, -6}}, color = {0, 0, 127}));
  end mdl_SIRsample;

  model mdl_SIRsample_w_betainput
      Modelica.Blocks.Sources.Constant Si(k = 999) annotation(
        Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant Ii(k = 1) annotation(
        Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant Ri(k = 0) annotation(
        Placement(visible = true, transformation(origin = {-70, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pk_SIRmodel.cl_SIRbetaInput cl_SIRbetaInput1 annotation(
        Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Beta_val_step(height = -0.3 / 1000, offset = 0.5 / 1000, startTime = 12) annotation(
      Placement(visible = true, transformation(origin = {-10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
  connect(Beta_val_step.y, cl_SIRbetaInput1.contact_rate) annotation(
      Line(points = {{1, 50}, {10, 50}, {10, 12}}, color = {0, 0, 127}));
  connect(Ii.y, cl_SIRbetaInput1.Ii) annotation(
      Line(points = {{-58, 0}, {-2, 0}}, color = {0, 0, 127}));
  connect(Si.y, cl_SIRbetaInput1.Si) annotation(
      Line(points = {{-59, 40}, {-40, 40}, {-40, 6}, {-2, 6}}, color = {0, 0, 127}));
  connect(Ri.y, cl_SIRbetaInput1.Ri) annotation(
      Line(points = {{-59, -40}, {-40, -40}, {-40, -6}, {-2, -6}}, color = {0, 0, 127}));
  protected
  end mdl_SIRsample_w_betainput;

  model mdl_SIRvaccine
    Modelica.Blocks.Sources.Constant Si(k = 999) annotation(
      Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant Ii(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant Ri(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-70, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    cl_Vaccine vaccine1(vaccine_rate = 0.5) annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  cl_SIRbetaInput cl_SIRbetaInput1 annotation(
      Placement(visible = true, transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step Beta_val_step(height = 0 / 1000, offset = 0.5 / 1000, startTime = 12) annotation(
      Placement(visible = true, transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Ii.y, vaccine1.Ii) annotation(
      Line(points = {{-58, 0}, {-12, 0}, {-12, 0}, {-10, 0}}, color = {0, 0, 127}));
    connect(Si.y, vaccine1.Si) annotation(
      Line(points = {{-59, 40}, {-40, 40}, {-40, 6}, {-10, 6}}, color = {0, 0, 127}));
    connect(Ri.y, vaccine1.Ri) annotation(
      Line(points = {{-59, -40}, {-40, -40}, {-40, -6}, {-10, -6}}, color = {0, 0, 127}));
    connect(vaccine1.Sy, cl_SIRbetaInput1.Si) annotation(
      Line(points = {{12, 6}, {36, 6}, {36, 6}, {38, 6}}, color = {0, 0, 127}));
    connect(vaccine1.Iy, cl_SIRbetaInput1.Ii) annotation(
      Line(points = {{12, 0}, {36, 0}, {36, 0}, {38, 0}}, color = {0, 0, 127}));
    connect(vaccine1.Ry, cl_SIRbetaInput1.Ri) annotation(
      Line(points = {{12, -6}, {36, -6}, {36, -6}, {38, -6}}, color = {0, 0, 127}));
  connect(Beta_val_step.y, cl_SIRbetaInput1.contact_rate) annotation(
      Line(points = {{42, 50}, {50, 50}, {50, 12}, {50, 12}}, color = {0, 0, 127}));
  protected
  end mdl_SIRvaccine;


  model mdl_SIRmodel_reinfect
    Modelica.Blocks.Sources.Constant Si(k = 999) annotation(
      Placement(visible = true, transformation(origin = {-90, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant Ii(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Constant Ri(k = 0) annotation(
      Placement(visible = true, transformation(origin = {-90, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    pk_SIRmodel.cl_Vaccine vaccine1(vaccine_rate = 0)  annotation(
      Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.Step Beta_val_step(height = 0 / 1000, offset = 0.5 / 1000, startTime = 12) annotation(
      Placement(visible = true, transformation(origin = {10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  pk_SIRmodel.cl_SIRreinfect cl_SIRreinfect1(dying_rate = 0.2, reinfect_rate = 0)  annotation(
      Placement(visible = true, transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Ii.y, vaccine1.Ii) annotation(
      Line(points = {{-79, 0}, {-52, 0}}, color = {0, 0, 127}));
    connect(Si.y, vaccine1.Si) annotation(
      Line(points = {{-79, 40}, {-70, 40}, {-70, 6}, {-52, 6}}, color = {0, 0, 127}));
    connect(Ri.y, vaccine1.Ri) annotation(
      Line(points = {{-79, -40}, {-70, -40}, {-70, -6}, {-52, -6}}, color = {0, 0, 127}));
  connect(vaccine1.Sy, cl_SIRreinfect1.Si) annotation(
      Line(points = {{-28, 6}, {18, 6}}, color = {0, 0, 127}));
  connect(Beta_val_step.y, cl_SIRreinfect1.contact_rate) annotation(
      Line(points = {{22, 50}, {30, 50}, {30, 12}}, color = {0, 0, 127}));
  connect(vaccine1.Iy, cl_SIRreinfect1.Ii) annotation(
      Line(points = {{-28, 0}, {16, 0}, {16, 0}, {18, 0}}, color = {0, 0, 127}));
  connect(vaccine1.Ry, cl_SIRreinfect1.Ri) annotation(
      Line(points = {{-28, -6}, {16, -6}, {16, -6}, {18, -6}}, color = {0, 0, 127}));
  protected
    annotation(
      Diagram(graphics = {Text(origin = {45, 22}, lineColor = {255, 0, 0}, extent = {{-11, 4}, {23, -8}}, textString = "SIR再感染モデル"), Text(origin = {9, 72}, lineColor = {255, 0, 0}, extent = {{-15, 2}, {17, -6}}, textString = "SIR β値を制御"), Text(origin = {41, -42}, lineColor = {0, 85, 0}, extent = {{-11, 4}, {37, -6}}, textString = "新規感染者数Output"), Text(origin = {-39, 20}, lineColor = {255, 0, 0}, extent = {{-15, 4}, {11, -4}}, textString = "ワクチン効果"), Line(origin = {39.9856, -35.4753}, points = {{-4, -2}, {-16, 22}}, color = {0, 85, 0}, pattern = LinePattern.Dash), Text(origin = {55, -34}, lineColor = {0, 85, 0}, extent = {{-11, 4}, {25, -2}}, textString = "死亡者数Output"), Line(origin = {26.8276, -21.1154}, points = {{4, 8}, {16, -8}}, color = {0, 85, 0}, pattern = LinePattern.Dash), Text(origin = {69, -22}, lineColor = {0, 85, 0}, extent = {{-13, 6}, {33, -6}}, textString = "生存回復者数Output"), Line(origin = {36.2649, -16.1799}, points = {{2, 4}, {18, -6}}, color = {0, 85, 0}, pattern = LinePattern.Dash)}, coordinateSystem(extent = {{-120, -100}, {120, 100}}, initialScale = 0.1)),
      Icon(coordinateSystem(extent = {{-120, -100}, {120, 100}})));
  end mdl_SIRmodel_reinfect;
  annotation(
    uses(Modelica(version = "3.2.3")));
end pk_SIRmodel;
