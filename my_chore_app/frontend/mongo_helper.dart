import 'package:mongo_dart/mongo_dart.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class DatabaseService {
  final Db _db;

  DatabaseService(String uri) : _db = Db(uri);

  Future<void> openConnection() async {
    try {
      await _db.open();
      logger.i('Connected to MongoDB');
    } catch (e) {
      logger.e('Failed to connect to MongoDB: $e');
      rethrow; // Optionally rethrow the exception for higher-level handling
    }
  }

  // Add methods for performing CRUD operations here
}

// Initialize the database service with your MongoDB URI
final databaseService = DatabaseService('http://127.0.0.1:5000');
//http://127.0.0.1:5000/create_chore
Future<void> initializeDatabase() async {
  try {
    await databaseService.openConnection();
    logger.i('Database connected successfully');
  } catch (e) {
    logger.e('Database initialization error: $e');
  }
}
