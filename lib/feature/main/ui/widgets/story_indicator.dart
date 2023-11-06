import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izobility_mobile/feature/main/bloc/story/story_cubit.dart';

class StoryDurationIndicator extends StatefulWidget {
  const StoryDurationIndicator(
      {super.key,
      required this.width,
      required this.duration,
      required this.index});

  final double width;
  final Duration duration;
  final int index;

  @override
  State<StoryDurationIndicator> createState() => _StoryDurationIndicatorState();
}

class _StoryDurationIndicatorState extends State<StoryDurationIndicator> {
  @override
  void initState() {
    activateListener();
    super.initState();
  }

  void activateListener() {
    final bloc = BlocProvider.of<StoryCubit>(context);
    if (widget.index == bloc.currentStoryIndex) {
      try {
        bloc.controller!.addListener(() {
          if (widget.index == bloc.currentStoryIndex) {
            setState(() {});
          }
        });
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StoryCubit>(context);

    return BlocListener<StoryCubit, StoryState>(
      listener: (context, state) {
        activateListener();
      },
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<StoryCubit>(context).changeStory(index: widget.index);
        },
        child: Container(
          color: Colors.transparent,
          height: 18,
          width: widget.width,
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: LinearProgressIndicator(
              value: bloc.currentStoryIndex > widget.index
                  ? 1
                  : bloc.currentStoryIndex < widget.index
                      ? 0
                      : bloc.controller != null
                          ? bloc.controller!.value
                          : 0,
              borderRadius: BorderRadius.circular(1),
              backgroundColor: Colors.white.withOpacity(0.4),
              color: Colors.white),
        ),
      ),
    );
  }
}
