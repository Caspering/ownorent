import 'package:flutter/material.dart';

class TextSize {
  double h(context) {
    return (25 / 720) * MediaQuery.of(context).size.height;
  }

  double h1(context) {
    return (20 / 720) * MediaQuery.of(context).size.height;
  }

  double h2(context) {
    return (18 / 720) * MediaQuery.of(context).size.height;
  }

  double h3(context) {
    return (15 / 720) * MediaQuery.of(context).size.height;
  }

  double p(context) {
    return (13 / 720) * MediaQuery.of(context).size.height;
  }

  double small(context) {
    return (11 / 720) * MediaQuery.of(context).size.height;
  }

  double custom(fsize, context) {
    return (fsize / 720) * MediaQuery.of(context).size.height;
  }
}
