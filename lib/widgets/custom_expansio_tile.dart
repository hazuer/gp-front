import 'package:flutter/material.dart';

const Duration _kExpand = const Duration(milliseconds: 200);

class AppExpansionTile extends StatefulWidget {
    const AppExpansionTile({
        Key? key,
        this.leading,
        required this.title,
        this.backgroundColor,
        this.onExpansionChanged,
        this.children: const <Widget>[],
        this.trailing,
        this.initiallyExpanded: false,
    })
        : assert(initiallyExpanded != null),
            super(key: key);

    final Widget? leading;
    final Widget title;
    final ValueChanged<bool>? onExpansionChanged;
    final List<Widget> children;
    final Color? backgroundColor;
    final Widget? trailing;
    final bool? initiallyExpanded;

    @override
    AppExpansionTileState createState() => new AppExpansionTileState();
}

class AppExpansionTileState extends State<AppExpansionTile> with SingleTickerProviderStateMixin {
    late AnimationController _controller;
    late CurvedAnimation _easeOutAnimation;
    late CurvedAnimation _easeInAnimation;
    late ColorTween _borderColor;
    late ColorTween _headerColor;
    late ColorTween _iconColor;
    late ColorTween _backgroundColor;
    late Animation<double> _iconTurns;
    

    bool _isExpanded = false;

    @override
    void initState() {
        super.initState();
        _controller = new AnimationController(duration: _kExpand, vsync: this);
        _easeOutAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
        _easeInAnimation = new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
        _borderColor = new ColorTween();
        _headerColor = new ColorTween();
        _iconColor = new ColorTween();
        _iconTurns = new Tween<double>(begin: 0.0, end: 0.5).animate(_easeInAnimation);
        _backgroundColor = new ColorTween();

        _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
        if (_isExpanded)
            _controller.value = 1.0;
    }

    @override
    void dispose() {
        _controller.dispose();
        super.dispose();
    }

    void expand() {
        _setExpanded(true);
    }

    void collapse() {
        _setExpanded(false);
    }

    void toggle() {
        _setExpanded(!_isExpanded);
    }

    void _setExpanded(bool isExpanded) {
        if (_isExpanded != isExpanded) {
            setState(() {
                _isExpanded = isExpanded;
                if (_isExpanded)
                    _controller.forward();
                else
                    _controller.reverse().then<void>(( value) {
                        setState(() {
                            // Rebuild without widget.children.
                        });
                    });
                PageStorage.of(context)?.writeState(context, _isExpanded);
            });
            if (widget.onExpansionChanged != null) {
                widget.onExpansionChanged!(_isExpanded);
            }
        }
    }

    Widget _buildChildren(BuildContext context, Widget? child) {
        //final Color borderSideColor = _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;
        final Color? titleColor = _headerColor.evaluate(_easeInAnimation);

        return new Container(
          padding: EdgeInsets.zero,
            decoration: new BoxDecoration(
                color: _backgroundColor.evaluate(_easeOutAnimation) ?? Colors.transparent,
            ),
            child: new Column(
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    IconTheme.merge(
                        data: new IconThemeData(color: _iconColor.evaluate(_easeInAnimation)),
                        child: new ListTile(
                            onTap: toggle,
                            //leading: widget.leading,
                            title: new DefaultTextStyle(
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: titleColor),
                                child: widget.title,
                            ),
                            trailing: widget.trailing ?? new RotationTransition(
                                turns: _iconTurns,
                                child: const Icon(Icons.expand_more),
                            ),
                        ),
                    ),
                    new ClipRect(
                        child: new Align(
                            heightFactor: _easeInAnimation.value,
                            child: child,
                        ),
                    ),
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        final ThemeData theme = Theme.of(context);
        _borderColor.end = theme.dividerColor;
        _headerColor
            ..begin = theme.textTheme.subtitle1!.color
            ..end = theme.accentColor;
        _iconColor
            ..begin = theme.unselectedWidgetColor
            ..end = theme.accentColor;
        _backgroundColor.end = widget.backgroundColor;

        final bool closed = !_isExpanded && _controller.isDismissed;
        return new AnimatedBuilder(
            animation: _controller.view,
            builder: _buildChildren,
            child: closed ? null : new Column(children: widget.children),
        );
    }
}



/*import 'package:flutter/material.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class CustomExpansionTile extends StatefulWidget {
 
  const CustomExpansionTile({
    Key key,
    this.headerBackgroundColor,
    this.leading,
    @required this.title,
    this.backgroundColor,
    this.iconColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  
  final Widget leading;

  
  final Widget title;

  final ValueChanged<bool> onExpansionChanged;

  
  final List<Widget> children;

  /// The color to display behind the sublist when expanded.
  final Color backgroundColor;

  /// The color to display the background of the header.
  final Color headerBackgroundColor;

  /// The color to display the icon of the header.
  final Color iconColor;

  /// A widget to display instead of a rotating arrow icon.
  final Widget trailing;

  /// Specifies if the list tile is initially expanded (true) or collapsed (false, the default).
  final bool initiallyExpanded;

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  //static final Animatable<double> _halfTween =Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  AnimationController _controller;
  //Animation<double> _iconTurns;
  Animation<double> _heightFactor;
  //Animation<Color> _borderColor;
  Animation<Color> _headerColor;
  Animation<Color> _iconColor;
  Animation<Color> _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    //_iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    //_borderColor = _controller.drive(_borderColorTween.chain(_easeOutTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor =
        _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    final Color borderSideColor = Colors.transparent; //_borderColor.value ?? Colors.transparent;
    final Color titleColor = _headerColor.value;

    return Container(
      decoration: BoxDecoration(
          color: _backgroundColor.value ?? Colors.transparent,
          border: Border(
            top: BorderSide(color: borderSideColor),
            bottom: BorderSide(color: borderSideColor),
          )),
      child: Column(
        //mainAxisSize: MainAxisSize.max,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconTheme.merge(
            data: IconThemeData(color: _iconColor.value),
            child: Container(
              color: widget.headerBackgroundColor ?? Colors.transparent,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: _handleTap,
                leading: widget.leading,
                title: DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      // ignore: deprecated_member_use
                      .subhead
                      .copyWith(color: titleColor),
                  child: widget.title,
                ),
                trailing: widget.trailing ??
                Container(width: 0, height: 0,)
                    /*RotationTransition(
                      turns: _iconTurns,
                      child: Icon(
                        Icons.expand_more,
                        color: widget.iconColor ?? Colors.grey,
                      ),
                    ),*/
              ),
            ),
          ),
          ClipRect(
            child: Align(
              alignment: Alignment.centerRight,
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween..end = theme.dividerColor;
    _headerColorTween
      // ignore: deprecated_member_use
      ..begin = theme.textTheme.subhead.color
      ..end = theme.accentColor;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;
    _backgroundColorTween..end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}*/
