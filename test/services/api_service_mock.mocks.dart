// Mocks generated by Mockito 5.4.5 from annotations
// in note_taking_app/test/services/api_service_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:note_taking_app/models/quote_model.dart' as _i2;
import 'package:note_taking_app/services/api_services.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeQuoteModel_0 extends _i1.SmartFake implements _i2.QuoteModel {
  _FakeQuoteModel_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [ApiServices].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiServices extends _i1.Mock implements _i3.ApiServices {
  MockApiServices() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.QuoteModel> fetchRandomQuote() =>
      (super.noSuchMethod(
            Invocation.method(#fetchRandomQuote, []),
            returnValue: _i4.Future<_i2.QuoteModel>.value(
              _FakeQuoteModel_0(this, Invocation.method(#fetchRandomQuote, [])),
            ),
          )
          as _i4.Future<_i2.QuoteModel>);
}