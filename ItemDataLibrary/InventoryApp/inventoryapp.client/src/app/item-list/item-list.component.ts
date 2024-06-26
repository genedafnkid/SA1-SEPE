import { Component, OnInit, OnDestroy } from '@angular/core';
import { ItemService } from '../item.service';
import { Subscription } from 'rxjs';


@Component({
  selector: 'app-item-list',
  templateUrl: './item-list.component.html',
  styleUrls: ['./item-list.component.css']
})
export class ItemListComponent implements OnInit, OnDestroy {
  items: any[] = [];
  itemAddedSubscription: Subscription = new Subscription(); 


  constructor(private itemService: ItemService) { }

  ngOnInit(): void {
    this.loadItems();
    this.itemAddedSubscription = this.itemService.itemAdded$.subscribe(() => {
      this.loadItems();
    });
  }

  ngOnDestroy(): void {
    this.itemAddedSubscription.unsubscribe();
  }


  loadItems(): void {
    this.itemService.getItems().subscribe({
      next: items => {
        this.items = items;
      },
      error: err => {
        console.error('Error loading items:', err);
      }
    });
  }
}
