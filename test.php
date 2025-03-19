<?php

namespace Tests;

use HttpKernel\TestCase;

final class Test extends TestCase
{
    public function __construct(
        public readonly int $a,
    ) {}

    public function boo(bool $b): string
    {
        if ($b) {
            return 'foo' . $b;
        }

        return 'bar';
    }
}
