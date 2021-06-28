// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/posts.dart';
import 'package:wasteagram/main.dart';

void main() {
  test('Testing post model', () {
    final date = DateTime.now();
    const latitude = 20.1;
    const longitude = -16.4;
    const url = '/image/test';
    const quantity = 19;

    final post = Posts(
        dateTime: date,
        latitude: latitude,
        longitude: longitude,
        url: url,
        waste: quantity
    );
    expect(post.dateTime, date);
    expect(post.latitude, latitude);
    expect (post.longitude, longitude);
    expect (post.url, url);
    expect( post.waste, quantity);
  });
}
