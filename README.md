## Features

This is a singleton instance manager for Dart.

- Automatically creates an instance when none exists.
- No need to pre-register factory methods for creating instances.

## Usage

```dart

class FooService {}

class BarService {
  final String name;

  const BarService(this.name);
}

FooService _createFooService(EmptyOption _) {
  return FooService();
}

FooService _createBarService(String name) {
  return BarService(name);
}

const instanceProvider = SingletonProvider();
const fooServiceMeta = InstanceMeta(_createFooService, emptyOption);
const barServiceMeta = InstanceMeta(_createBarService, "BarA");

// get instance
final fooService = instanceProvider.get(fooServiceMeta);
final barService = instanceProvider.get(barServiceMeta);

```

## License

This project is licensed under the MIT license.


## Additional information

```InstanceMeta``` overrides ```==``` and ```hashCode```, deliberately ignoring the builder so that different closures can be passed. If multiple instances of the same type are needed, you should modify the options to achieve this.