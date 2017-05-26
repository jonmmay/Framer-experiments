require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"LayerExtendedTouchEvents":[function(require,module,exports){
var LayerExtendedTouchEvents,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Events.TouchUpInside = "touchUpInside";

Events.TouchUpOutside = "touchUpOutside";

LayerExtendedTouchEvents = (function(superClass) {
  extend(LayerExtendedTouchEvents, superClass);

  function LayerExtendedTouchEvents(options) {
    var base, doesWindowListenterExist, windowListener;
    this.options = options != null ? options : {};
    if ((base = this.options)._hasTouch == null) {
      base._hasTouch = false;
    }
    LayerExtendedTouchEvents.__super__.constructor.call(this, this.options);
    this.on(Events.TouchStart, function() {
      return this.options._hasTouch = true;
    });
    this.on(Events.TouchEnd, function(e, layer) {
      this.options._hasTouch = false;
      return layer.emit(Events.TouchUpInside, e, layer);
    });
    doesWindowListenterExist = function() {
      var i, layer, len, ref, windowListeners;
      windowListeners = 0;
      ref = Framer.CurrentContext.layers;
      for (i = 0, len = ref.length; i < len; i++) {
        layer = ref[i];
        if (typeof layer._hasTouch !== "undefined") {
          windowListeners += 1;
        }
      }
      if (windowListeners <= 1) {
        return false;
      } else {
        return true;
      }
    };
    windowListener = function(e) {
      var i, layer, layers, len, results;
      layers = Framer.CurrentContext.layers;
      results = [];
      for (i = 0, len = layers.length; i < len; i++) {
        layer = layers[i];
        if (layer._hasTouch) {
          results.push(layer.emit(Events.TouchUpOutside, e, layer));
        } else {
          results.push(void 0);
        }
      }
      return results;
    };
    if (doesWindowListenterExist() === false) {
      window.addEventListener("mouseup", windowListener);
    }
  }

  LayerExtendedTouchEvents.define("_hasTouch", {
    get: function() {
      return this.options._hasTouch;
    },
    set: function(bool) {
      return this.options._hasTouch = bool;
    }
  });

  LayerExtendedTouchEvents.prototype.onTouchUpInside = function(cb) {
    return this.on(Events.TouchUpInside, cb);
  };

  LayerExtendedTouchEvents.prototype.onTouchUpOutside = function(cb) {
    return this.on(Events.TouchUpOutside, cb);
  };

  return LayerExtendedTouchEvents;

})(Layer);

module.exports = LayerExtendedTouchEvents;


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZnJhbWVyLm1vZHVsZXMuanMiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL1VzZXJzL2pvbmF0aGFubWF5LyBXb3JraW5nIEZpbGVzL0ZyYW1lci9HaXRodWIvU25hcC1zbGlkZXIuZnJhbWVyL21vZHVsZXMvbXlNb2R1bGUuY29mZmVlIiwiLi4vLi4vLi4vLi4vLi4vVXNlcnMvam9uYXRoYW5tYXkvIFdvcmtpbmcgRmlsZXMvRnJhbWVyL0dpdGh1Yi9TbmFwLXNsaWRlci5mcmFtZXIvbW9kdWxlcy9MYXllckV4dGVuZGVkVG91Y2hFdmVudHMuY29mZmVlIiwibm9kZV9tb2R1bGVzL2Jyb3dzZXItcGFjay9fcHJlbHVkZS5qcyJdLCJzb3VyY2VzQ29udGVudCI6WyIjIEFkZCB0aGUgZm9sbG93aW5nIGxpbmUgdG8geW91ciBwcm9qZWN0IGluIEZyYW1lciBTdHVkaW8uIFxuIyBteU1vZHVsZSA9IHJlcXVpcmUgXCJteU1vZHVsZVwiXG4jIFJlZmVyZW5jZSB0aGUgY29udGVudHMgYnkgbmFtZSwgbGlrZSBteU1vZHVsZS5teUZ1bmN0aW9uKCkgb3IgbXlNb2R1bGUubXlWYXJcblxuZXhwb3J0cy5teVZhciA9IFwibXlWYXJpYWJsZVwiXG5cbmV4cG9ydHMubXlGdW5jdGlvbiA9IC0+XG5cdHByaW50IFwibXlGdW5jdGlvbiBpcyBydW5uaW5nXCJcblxuZXhwb3J0cy5teUFycmF5ID0gWzEsIDIsIDNdIiwiIyBFeHRlbmQgbGF5ZXIgdG8gcHJvZHVjZSB0d28gZXZlbnRzOlxuIyBcdHRvdWNoIHVwIGluc2lkZSAtIHRyaWdnZXIgZXZlbnQgd2hlbiB0aGUgdG91Y2ggZXZlbnQgZW5kcyBpbnNpZGUgdGhlIGxheWVyJ3MgZnJhbWVcbiMgXHR0b3VjaCB1cCBvdXRzaWRlIC0gdHJpZ2dlciBldmVudCB3aGVuIHRoZSB0b3VjaCBldmVudCBlbmRzIG91dHNpZGUgdGhlIGxheWVyJ3MgZnJhbWVcblxuRXZlbnRzLlRvdWNoVXBJbnNpZGUgPSBcInRvdWNoVXBJbnNpZGVcIlxuRXZlbnRzLlRvdWNoVXBPdXRzaWRlID0gXCJ0b3VjaFVwT3V0c2lkZVwiXG5cbmNsYXNzIExheWVyRXh0ZW5kZWRUb3VjaEV2ZW50cyBleHRlbmRzIExheWVyXG5cdGNvbnN0cnVjdG9yOiAoIEBvcHRpb25zPXt9ICkgLT5cblx0XHRAb3B0aW9ucy5faGFzVG91Y2ggPz0gZmFsc2Vcblx0XHRzdXBlciBAb3B0aW9uc1xuXG5cdFx0IyBzZXQgaGVscGVyIF9oYXNUb3VjaCBwcm9wZXJ0eSBvbiB0b3VjaCBzdGFydCBhbmQgZW5kIGV2ZW50c1xuXHRcdEBvbiggRXZlbnRzLlRvdWNoU3RhcnQsIC0+XG5cdFx0XHRAb3B0aW9ucy5faGFzVG91Y2ggPSB0cnVlXG5cdFx0KVxuXHRcdEBvbiggRXZlbnRzLlRvdWNoRW5kLCAoIGUsIGxheWVyICkgLT5cblx0XHRcdEBvcHRpb25zLl9oYXNUb3VjaCA9IGZhbHNlXG5cdFx0XHRsYXllci5lbWl0KCBFdmVudHMuVG91Y2hVcEluc2lkZSwgZSwgbGF5ZXIgKVxuXHRcdClcblxuXHRcdGRvZXNXaW5kb3dMaXN0ZW50ZXJFeGlzdCA9IC0+XG5cdFx0XHR3aW5kb3dMaXN0ZW5lcnMgPSAwXG5cdFx0XHQjIENoZWNrIGlmIG90aGVyIGxheWVycyBhcmUgbGlzdGVuaW5nIHRvIHdpbmRvdydzIG1vdXNldXAgZXZlbnRzXG5cdFx0XHRmb3IgbGF5ZXIgaW4gRnJhbWVyLkN1cnJlbnRDb250ZXh0LmxheWVyc1xuXHRcdFx0XHRpZiB0eXBlb2YgbGF5ZXIuX2hhc1RvdWNoICE9IFwidW5kZWZpbmVkXCJcblx0XHRcdFx0XHR3aW5kb3dMaXN0ZW5lcnMgKz0gMVxuXG5cdFx0XHRpZiB3aW5kb3dMaXN0ZW5lcnMgPD0gMVxuXHRcdFx0XHRyZXR1cm4gZmFsc2Vcblx0XHRcdGVsc2UgXG5cdFx0XHRcdHJldHVybiB0cnVlXG5cblx0XHR3aW5kb3dMaXN0ZW5lciA9ICggZSApIC0+XG5cdFx0XHRsYXllcnMgPSBGcmFtZXIuQ3VycmVudENvbnRleHQubGF5ZXJzXG5cdFx0XHRmb3IgbGF5ZXIgaW4gbGF5ZXJzXG5cdFx0XHRcdGlmIGxheWVyLl9oYXNUb3VjaFxuXHRcdFx0XHRcdGxheWVyLmVtaXQoIEV2ZW50cy5Ub3VjaFVwT3V0c2lkZSwgZSwgbGF5ZXIgKVxuXG5cdFx0IyBJZiBhIHByZWV4aXN0aW5nIGV2ZW50IGxpc3RlbmVyIGRvZXNuJ3QgZXhpc3QsIGNyZWF0ZSBvbmVcblx0XHRpZiBkb2VzV2luZG93TGlzdGVudGVyRXhpc3QoKSA9PSBmYWxzZVxuXHRcdFx0d2luZG93LmFkZEV2ZW50TGlzdGVuZXIoIFwibW91c2V1cFwiLCB3aW5kb3dMaXN0ZW5lciApXG5cblx0QGRlZmluZSBcIl9oYXNUb3VjaFwiLFxuXHRcdGdldDogLT5cblx0XHRcdHJldHVybiBAb3B0aW9ucy5faGFzVG91Y2hcblx0XHRzZXQ6ICggYm9vbCApIC0+XG5cdFx0XHRAb3B0aW9ucy5faGFzVG91Y2ggPSBib29sXG5cblx0IyBIZWxwZXIgRXZlbnRzXG5cdG9uVG91Y2hVcEluc2lkZTogKCBjYiApIC0+IEBvbiggRXZlbnRzLlRvdWNoVXBJbnNpZGUsIGNiIClcblx0b25Ub3VjaFVwT3V0c2lkZTogKCBjYiApIC0+IEBvbiggRXZlbnRzLlRvdWNoVXBPdXRzaWRlLCBjYiApXG5cbm1vZHVsZS5leHBvcnRzID0gTGF5ZXJFeHRlbmRlZFRvdWNoRXZlbnRzIiwiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFFQUE7QURJQSxJQUFBLHdCQUFBO0VBQUE7OztBQUFBLE1BQU0sQ0FBQyxhQUFQLEdBQXVCOztBQUN2QixNQUFNLENBQUMsY0FBUCxHQUF3Qjs7QUFFbEI7OztFQUNRLGtDQUFFLE9BQUY7QUFDWixRQUFBO0lBRGMsSUFBQyxDQUFBLDRCQUFELFVBQVM7O1VBQ2YsQ0FBQyxZQUFhOztJQUN0QiwwREFBTSxJQUFDLENBQUEsT0FBUDtJQUdBLElBQUMsQ0FBQSxFQUFELENBQUssTUFBTSxDQUFDLFVBQVosRUFBd0IsU0FBQTthQUN2QixJQUFDLENBQUEsT0FBTyxDQUFDLFNBQVQsR0FBcUI7SUFERSxDQUF4QjtJQUdBLElBQUMsQ0FBQSxFQUFELENBQUssTUFBTSxDQUFDLFFBQVosRUFBc0IsU0FBRSxDQUFGLEVBQUssS0FBTDtNQUNyQixJQUFDLENBQUEsT0FBTyxDQUFDLFNBQVQsR0FBcUI7YUFDckIsS0FBSyxDQUFDLElBQU4sQ0FBWSxNQUFNLENBQUMsYUFBbkIsRUFBa0MsQ0FBbEMsRUFBcUMsS0FBckM7SUFGcUIsQ0FBdEI7SUFLQSx3QkFBQSxHQUEyQixTQUFBO0FBQzFCLFVBQUE7TUFBQSxlQUFBLEdBQWtCO0FBRWxCO0FBQUEsV0FBQSxxQ0FBQTs7UUFDQyxJQUFHLE9BQU8sS0FBSyxDQUFDLFNBQWIsS0FBMEIsV0FBN0I7VUFDQyxlQUFBLElBQW1CLEVBRHBCOztBQUREO01BSUEsSUFBRyxlQUFBLElBQW1CLENBQXRCO0FBQ0MsZUFBTyxNQURSO09BQUEsTUFBQTtBQUdDLGVBQU8sS0FIUjs7SUFQMEI7SUFZM0IsY0FBQSxHQUFpQixTQUFFLENBQUY7QUFDaEIsVUFBQTtNQUFBLE1BQUEsR0FBUyxNQUFNLENBQUMsY0FBYyxDQUFDO0FBQy9CO1dBQUEsd0NBQUE7O1FBQ0MsSUFBRyxLQUFLLENBQUMsU0FBVDt1QkFDQyxLQUFLLENBQUMsSUFBTixDQUFZLE1BQU0sQ0FBQyxjQUFuQixFQUFtQyxDQUFuQyxFQUFzQyxLQUF0QyxHQUREO1NBQUEsTUFBQTsrQkFBQTs7QUFERDs7SUFGZ0I7SUFPakIsSUFBRyx3QkFBQSxDQUFBLENBQUEsS0FBOEIsS0FBakM7TUFDQyxNQUFNLENBQUMsZ0JBQVAsQ0FBeUIsU0FBekIsRUFBb0MsY0FBcEMsRUFERDs7RUFoQ1k7O0VBbUNiLHdCQUFDLENBQUEsTUFBRCxDQUFRLFdBQVIsRUFDQztJQUFBLEdBQUEsRUFBSyxTQUFBO0FBQ0osYUFBTyxJQUFDLENBQUEsT0FBTyxDQUFDO0lBRFosQ0FBTDtJQUVBLEdBQUEsRUFBSyxTQUFFLElBQUY7YUFDSixJQUFDLENBQUEsT0FBTyxDQUFDLFNBQVQsR0FBcUI7SUFEakIsQ0FGTDtHQUREOztxQ0FPQSxlQUFBLEdBQWlCLFNBQUUsRUFBRjtXQUFVLElBQUMsQ0FBQSxFQUFELENBQUssTUFBTSxDQUFDLGFBQVosRUFBMkIsRUFBM0I7RUFBVjs7cUNBQ2pCLGdCQUFBLEdBQWtCLFNBQUUsRUFBRjtXQUFVLElBQUMsQ0FBQSxFQUFELENBQUssTUFBTSxDQUFDLGNBQVosRUFBNEIsRUFBNUI7RUFBVjs7OztHQTVDb0I7O0FBOEN2QyxNQUFNLENBQUMsT0FBUCxHQUFpQjs7OztBRGpEakIsT0FBTyxDQUFDLEtBQVIsR0FBZ0I7O0FBRWhCLE9BQU8sQ0FBQyxVQUFSLEdBQXFCLFNBQUE7U0FDcEIsS0FBQSxDQUFNLHVCQUFOO0FBRG9COztBQUdyQixPQUFPLENBQUMsT0FBUixHQUFrQixDQUFDLENBQUQsRUFBSSxDQUFKLEVBQU8sQ0FBUCJ9
