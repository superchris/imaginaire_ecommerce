from typing import TypeVar, Generic, Union, Optional, Protocol, Tuple, List, Any, Self
from enum import Flag, Enum, auto
from dataclasses import dataclass
from abc import abstractmethod
import weakref

from .types import Result, Ok, Err, Some



@dataclass
class LineItem:
    product: str
    quantity: int
    price: int

@dataclass
class Discount:
    description: str
    amount: int

@dataclass
class Order:
    customer: str
    line_items: List[LineItem]
    total: int

class ApplyDiscount(Protocol):

    @abstractmethod
    def apply_discount(self, order: Order) -> Optional[Discount]:
        raise NotImplementedError

