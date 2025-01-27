import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:note_taking_app/models/quote_model.dart';
import 'api_service_mock.mocks.dart';

void main() {
  group('ApiService', () {
    late MockApiServices mockApiServices;

    setUp(() {
      mockApiServices = MockApiServices();
    });

    test('should return a Quote when API call is successfull', () async {
      //Arrange
      const mockQuote = QuoteModel(
        content: 'Test Content Quote',
        author: 'Test Author',
      );
      when(mockApiServices.fetchRandomQuote()).thenAnswer(
        (_) async => mockQuote,
      );

      //Act
      final result = await mockApiServices.fetchRandomQuote();

      //Assert
      expect(result, isA<QuoteModel>());
      expect(result.content, 'Test Content Quote');
      expect(result.author, 'Test Author');
    });

    test('should throw an exception when API call fails', () async {
      //Arrange
      when(mockApiServices.fetchRandomQuote()).thenThrow(
        Exception('API error'),
      );

      //Act & Assert
      expect(mockApiServices.fetchRandomQuote(), throwsException);
    });
  });
}
