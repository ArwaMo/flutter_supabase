import 'package:supabase_flutter/supabase_flutter.dart';

supabaseConfig()async{
    await Supabase.initialize(
    url: 'https://ayboyquzlhivyikgrhmt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF5Ym95cXV6bGhpdnlpa2dyaG10Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAyMzU1OTUsImV4cCI6MjAxNTgxMTU5NX0.qGjc-bY41vWyKrFLWc2uky6BenV5B4jGUw7cDxaJVzk',
  );
}