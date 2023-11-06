part of 'story_cubit.dart';

@immutable
abstract class StoryState {}

class StoryInitial extends StoryState {}

class ChangeStory extends StoryState {}

class EndOfStories extends StoryState {}