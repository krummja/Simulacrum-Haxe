package common.extensions;

class IterableExtensions {
	public static overload extern inline function each<A>(it: Iterable<A>, fn: (item: A, idx: Int) -> Void) {
		var i = 0;
		for (x in it) {
			fn(x, i++);
		}
	}

	public static overload extern inline function each<A>(it: Iterable<A>, fn: (item: A) -> Void) {
		for (x in it) {
			fn(x);
		}
	}

	public static inline function has<T>(it: Iterable<T>, value: T): Bool {
		return Lambda.has(it, value);
	}

	public static inline function find<T>(it: Iterable<T>, fn: (value: T) -> Bool): T {
		return Lambda.find(it, fn);
	}

	public static inline function exists<T>(it: Iterable<T>, fn: (value: T) -> Bool): Bool {
		return Lambda.exists(it, fn);
	}

	public static inline function avg<T>(it: Iterable<T>, fn: (value: T) -> Float): Float {
		return it.sum(fn) / it.count();
	}

	public static inline function sum<T>(it: Iterable<T>, fn: (value: T) -> Float): Float {
		return it.fold((it, res) -> fn(it) + res, 0);
	}

	public static inline function fold<A, B>(it: Iterable<A>, fn: (item: A, result: B) -> B, first: B): B {
		return Lambda.fold(it, fn, first);
	}

	public static inline function count<A, B>(it: Iterable<A>): Int {
		return Lambda.count(it);
	}
}
