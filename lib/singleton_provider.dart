import 'dart:collection';

class SingletonProvider {
  final HashMap<InstanceMeta<Object?, Object?>, Object?> _singletonMap =
      HashMap();

  T get<T, O>(InstanceMeta<T, O> instanceMeta) {
    final Object? instance = _singletonMap.putIfAbsent(
      instanceMeta,
      () => instanceMeta.builder(instanceMeta.option),
    );
    return instance as T;
  }

  T? tryGet<T, O>(InstanceMeta<T, O> instanceMeta) {
    return contains(instanceMeta) ? get(instanceMeta) : null;
  }

  bool contains<T, O>(InstanceMeta<T, O> instanceMeta) {
    return _singletonMap.containsKey(instanceMeta);
  }

  T? remove<T, O>(InstanceMeta<T, O> instanceMeta) {
    return _singletonMap.remove(instanceMeta) as T?;
  }

  int get instanceCount => _singletonMap.length;
}

typedef InstanceBuilder<T, O> = T Function(O option);

class InstanceMeta<T, O> {
  final InstanceBuilder<T, O> builder;
  final O option;

  const InstanceMeta({required this.builder, required this.option});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstanceMeta &&
          runtimeType == other.runtimeType &&
          option == other.option;

  @override
  int get hashCode => option.hashCode;
}

const emptyOption = EmptyOption();

final class EmptyOption {
  const EmptyOption();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmptyOption && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
