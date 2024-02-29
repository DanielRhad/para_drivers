import 'package:flutter/material.dart';

class InfoDesignUIWidget extends StatefulWidget
{
  String? textInfo;
  IconData? iconData;

  InfoDesignUIWidget({this.textInfo, this.iconData});

  @override
  State<InfoDesignUIWidget> createState() => _InfoDesignUIWidgetState();
}



class _InfoDesignUIWidgetState extends State<InfoDesignUIWidget>
{
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: ListTile(
        leading: Icon(
          widget.iconData,
          color: Colors.white,
        ),
        title: Text(
          widget.textInfo!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
