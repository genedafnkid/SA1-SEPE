import { Component } from '@angular/core';
import { ItemService } from '../item.service';
import { ItemListComponent } from '../item-list/item-list.component';

@Component({
  selector: 'app-add-item',
  templateUrl: './add-item.component.html',
  styleUrls: ['./add-item.component.css']
})
export class AddItemComponent {
  itemName: string = '';
  itemCode: string = '';
  itemBrand: string = '';
  itemPrice: number = 0.0;

  constructor(private itemService: ItemService) { }

  onSubmit(): void {

    console.log('Type of this.itemPrice:', typeof this.itemPrice); 

    const newItem = {
      name: this.itemName,
      code: this.itemCode,
      brand: this.itemBrand,
      unitPrice: this.itemPrice
    };

    this.itemService.addItem(newItem).subscribe({
      next: response => {
        console.log('Item added successfully!', response.message);
        this.resetForm();
      },
      error: err => {
        console.error('Error adding item:', err);
      }
    });
  }

  resetForm(): void {
    this.itemName = '';
    this.itemCode = '';
    this.itemBrand = '';
    this.itemPrice = 0.0;
  }

  isValidForm(): boolean {
    return !!this.itemName && !!this.itemCode && !!this.itemBrand && this.itemPrice > 0;
  }

}
