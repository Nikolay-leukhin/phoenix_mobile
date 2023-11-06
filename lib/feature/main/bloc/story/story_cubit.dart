import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:izobility_mobile/feature/main/data/main_repository.dart';
import 'package:izobility_mobile/models/story.dart';
import 'package:izobility_mobile/utils/logic/enums.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  final MainScreenRepository repository;

  StoryCubit({required this.repository}) : super(StoryInitial()) {
    repository.loadingState.stream.listen((event) {
      if (event == LoadingStateEnum.success) {
        storiesList = repository.storiesList;
        storiesCount = storiesList.length;
      }
    });
  }

  AnimationController? controller;
  int currentStoryIndex = 0;
  int storiesCount = 0;

  List<Story> storiesList = [];

  bool paused = false;

  void playPause() {
    if (paused) {
      controller!
        ..forward(from: controller!.value)
        ..repeat();
    } else {
      controller!.stop();
    }
    paused = !paused;
  }

  void pause() {
    controller!.stop();
  }

  void play() {
    controller!
      ..forward(from: controller!.value)
      ..repeat();
  }

  void controllerListener() {
    if (controller!.value > 0.99) {
      changeStory();
    }
  }

  void initController(AnimationController newController,
      {int initialStoryIndex = 0}) {
    controller = newController;
    changeStory(index: initialStoryIndex);
  }

  void changeStory({int? index}) {
    currentStoryIndex = index ?? currentStoryIndex + 1;
    if (currentStoryIndex >= storiesCount) {
      controller!.stop();
      currentStoryIndex = 0;
      emit(EndOfStories());
    } else {
      controller!.value = 0;
      controller!.duration = storiesList[currentStoryIndex].duration;
      controller!.repeat();

      emit(ChangeStory());
    }
  }

  void prevStory() {
    if (currentStoryIndex > 0) {
      changeStory(index: currentStoryIndex - 1);
    }
  }

  void dispose() {
    controller = null;
    currentStoryIndex = 0;
    emit(ChangeStory());
  }
}
