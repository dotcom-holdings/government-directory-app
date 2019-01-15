import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';

class ItemSelectingValue {
  Map<String, dynamic> selected;

  ItemSelectingValue({selected}) {
    this.selected = selected ?? Map<String, dynamic>();
  }

  static ItemSelectingValue get empty => ItemSelectingValue();

  ItemSelectingValue copyWith({Map<String, dynamic> selected}) {
    return ItemSelectingValue(
      selected: selected ?? this.selected,
    );
  }

  @override
  String toString() => '$runtimeType(selected: $hashCode)';

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other))
      return true;
    if (other is! ItemSelectingValue)
      return false;
    final ItemSelectingValue typedOther = other;
    return DeepCollectionEquality().equals(typedOther.selected, selected);
  }

  @override
  int get hashCode => selected.hashCode;
}

class ItemSelectingController extends ValueNotifier<ItemSelectingValue> {
  ItemSelectingController({Map<String, dynamic> selected}) : super(
    selected == null ?
    ItemSelectingValue.empty :
    ItemSelectingValue(selected: selected)
  );

  ItemSelectingController.fromValue(ItemSelectingValue value)
    : super(value ?? ItemSelectingValue.empty);

  Map<String, dynamic> get selected => value.selected;
  set selected(Map<String, dynamic> newItems) {
    value = value.copyWith(selected: newItems);
  }

  void clear() {
    value = ItemSelectingValue.empty;
  }
}

class SingleSelectField extends StatefulWidget {
  final Key fieldKey;
  final Map<String, dynamic> initialValue;
  final String hintText;
  final String labelText;
  final String helperText;
  final String errorText;
  final FormFieldSetter<Map<String, dynamic>> onChanged;
  final ValueChanged<Map<String, dynamic>> onSubmitted;
  final ItemSelectingController controller;
  final bool enabled;
  final List<Map<String, dynamic>> options;

  const SingleSelectField({
    this.fieldKey,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.enabled = true,
    this.options,
  });

  @override
  _SingleOptionSelectFieldState createState() =>
    _SingleOptionSelectFieldState();
}

abstract class _SingleSelectFieldState extends State<SingleSelectField> {
  Text subtitle;

  void openPicker();

  Text getSubtitle() {
    if (widget.controller.selected.isEmpty) {
      return Text(
        widget.hintText ?? 'Please select...',
        style: TextStyle(fontSize: 14.0, color: Colors.grey),
      );
    }
    return Text(
      widget.controller.selected['label'],
      style: TextStyle(fontSize: 14.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 80.0,
          decoration: BoxDecoration(
            border: widget.errorText == null ? null : Border.all(
              width: 2.0,
              color: Theme.of(context).errorColor,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: openPicker,
            child: Card(
              margin: EdgeInsets.all(0.0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.labelText,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: subtitle ?? getSubtitle(),
                        )
                      ],
                    ),
                    Icon(Icons.chevron_right),
                  ],
                )
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.0, top: 5.0),
          child: Text(
            widget.errorText ?? '',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _SingleOptionSelectFieldState extends _SingleSelectFieldState {
  Map<String, dynamic> tmpValue;

  int get _selectedItemIndex {
    if (widget.controller.selected.isEmpty) {
      return 0;
    }
    return widget.options.indexWhere((Map<String, dynamic> option) {
      return option['value'] == widget.controller.selected['value'];
    });
  }

  @override
  openPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 260.0,
          color: CupertinoColors.white,
          child: Column(
            children: <Widget>[
              Container(
                height: 60.0,
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      widget.labelText,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.white),
                      onPressed: () {
                        if (tmpValue == null) {
                          setState(() {
                            tmpValue = widget.options[0];
                          });
                        }
                        widget.controller.selected = tmpValue;
                        setState(() {
                          subtitle = getSubtitle();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 200.0,
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: _selectedItemIndex,
                  ),
                  itemExtent: 45.0,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      tmpValue = widget.options[index];
                    });
                  },
                  children: widget.options.map((Map<String, dynamic> option) => (
                    Center(
                      child: Text(
                        option['label'],
                        style: TextStyle(fontSize: 18.0),
                      ),
                    )
                  )).toList(),
                ),
              )
            ],
          )
        );
      }
    );
  }
}

class SingleSelectFormField extends FormField<Map<String, dynamic>> {
  final ItemSelectingController controller;

  SingleSelectFormField({
    Key key,
    this.controller,
    Map<String, dynamic> initialValue,
    String hintText,
    String labelText,
    String helperText,
    List<Map<String, dynamic>> options,
    ValueChanged<Map<String, dynamic>> onFieldSubmitted,
    FormFieldSetter<Map<String, dynamic>> onSaved,
    FormFieldValidator<Map<String, dynamic>> validator,
    bool enabled,
  }) :
      assert(initialValue == null || controller == null),
      super(
      key: key,
      initialValue: getInitialValue(controller, initialValue),
      onSaved: onSaved,
      validator: validator,
      builder: (FormFieldState<Map<String, dynamic>> field) {
        final _SingleSelectFormFieldState state = field;
        return SingleSelectField(
          controller: state._effectiveController,
          initialValue: getInitialValue(controller, initialValue),
          hintText: hintText,
          labelText: labelText,
          helperText: helperText,
          errorText: field.errorText,
          onChanged: field.didChange,
          onSubmitted: onFieldSubmitted,
          enabled: enabled,
          options: options,
        );
      },
    );

  static Map<String, dynamic> getInitialValue(
    ItemSelectingController controller,
    Map<String, dynamic> initialValue,
    ) {
    return controller != null ?
    controller.selected : (initialValue ?? ItemSelectingValue.empty.selected);
  }

  @override
  _SingleSelectFormFieldState createState() => _SingleSelectFormFieldState();
}

class _SingleSelectFormFieldState
  extends FormFieldState<Map<String, dynamic>> {
  ItemSelectingController _controller;

  ItemSelectingController get _effectiveController =>
    widget.controller ?? _controller;

  @override
  SingleSelectFormField get widget => super.widget;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = ItemSelectingController(selected: widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(SingleSelectFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller = ItemSelectingController.fromValue(
          oldWidget.controller.value,
        );
      if (widget.controller != null) {
        setValue(widget.controller.selected);
        if (oldWidget.controller == null)
          _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.selected = widget.initialValue;
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.selected != value)
      didChange(_effectiveController.selected);
  }
}
