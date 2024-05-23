import 'package:flutter/material.dart';

class ExpandableSearchbar extends StatefulWidget {
  final Color contentColor;
  final Color backgroundColor;
  final double height;
  final double width;
  final TextEditingController controller;
  final String hintText;
  final int animationDuration;
  final Curve curve;
  final double iconSize;
  final double borderRadius;
  final double fontSize;
  final void Function() onSearch;
  final void Function() onHide;

  const ExpandableSearchbar({
    required this.contentColor,
    required this.backgroundColor,
    required this.width,
    required this.onSearch,
    required this.controller,
    required this.hintText,
    required this.onHide,
    this.height = 45,
    this.animationDuration = 250,
    this.curve = Curves.easeOut,
    this.iconSize = 20.0,
    this.borderRadius = 30.0,
    this.fontSize = 13.0,
    super.key,
  });

  @override
  State<ExpandableSearchbar> createState() => _ExpandableSearchbarState();
}

class _ExpandableSearchbarState extends State<ExpandableSearchbar>
    with SingleTickerProviderStateMixin {
  bool expanded = false;

  late AnimationController animationController;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    );
  }

  unfocus() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      color: widget.backgroundColor,
      elevation: expanded ? 5 : 0,
      child: Container(
        height: expanded ? widget.height : widget.iconSize * 2,
        alignment: Alignment.center,
        child: AnimatedContainer(
          decoration: BoxDecoration(
              color: expanded ? widget.backgroundColor : Colors.transparent,
              borderRadius: BorderRadius.circular(widget.borderRadius)),
          width: expanded ? widget.width : widget.iconSize * 2,
          duration: Duration(milliseconds: widget.animationDuration),
          curve: widget.curve,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: widget.animationDuration),
                curve: widget.curve,
                right: 0,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: widget.animationDuration),
                  opacity: expanded ? 1.0 : 0.0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: widget.animationDuration),
                    curve: widget.curve,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        unfocus();
                        animationController.reverse();
                        widget.controller.clear();
                        setState(() {
                          expanded = false;
                        });
                      },
                      icon: Icon(
                        Icons.close,
                        size: expanded ? widget.iconSize * 0.8 : 0,
                        color: widget.contentColor,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                bottom: 0,
                top: 0,
                left: expanded ? widget.iconSize * 2.2 : widget.iconSize,
                duration: Duration(milliseconds: widget.animationDuration),
                curve: widget.curve,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: widget.animationDuration),
                  opacity: expanded ? 1.0 : 0.0,
                  child: AnimatedContainer(
                    width: widget.width - (widget.iconSize * 4),
                    duration: Duration(milliseconds: widget.animationDuration),
                    curve: widget.curve,
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      controller: widget.controller,
                      focusNode: focusNode,
                      cursorRadius: const Radius.circular(30.0),
                      cursorWidth: 2.0,
                      cursorColor: widget.contentColor,
                      onSubmitted: (value) {
                        widget.onSearch();
                      },
                      onEditingComplete: () {
                        widget.onSearch();
                      },
                      style: TextStyle(
                        color: widget.contentColor,
                        fontSize: widget.fontSize,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 5),
                        isDense: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: widget.hintText,
                        labelStyle: TextStyle(
                          color: widget.contentColor,
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: widget.backgroundColor,
                child: IconButton(
                  onPressed: () {
                    if (!expanded) {
                      setState(() {
                        expanded = true;
                        animationController.forward();
                      });
                    }
                  },
                  icon: Icon(
                    Icons.search,
                    size: expanded ? widget.iconSize * 0.8 : widget.iconSize,
                    color: widget.contentColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
