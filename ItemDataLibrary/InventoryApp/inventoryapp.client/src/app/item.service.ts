// item.service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, Subject } from 'rxjs';
import { tap } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class ItemService {
  private itemAddedSource = new Subject<void>();
  private itemDeletedSource = new Subject<void>();
  itemDeleted$ = this.itemDeletedSource.asObservable();
  itemAdded$ = this.itemAddedSource.asObservable(); 
  constructor(private http: HttpClient) { }
  private readonly apiUrl = 'https://localhost:7149/api/ItemList';

  addItem(item: any): Observable<any> {
    return this.http.post<any>('https://localhost:7149/additem', item).pipe(
      tap(() => {
        this.announceItemAdded();
      })
    );
  }

  getItems(): Observable<any[]> {
    return this.http.get<any[]>(`https://localhost:7149/api/ItemList`);
  }

  announceItemAdded(): void {
    this.itemAddedSource.next();
  }

  anounceItemDeleted(): void {
    this.itemDeletedSource.next();
  }

  deleteItem(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/${id}`).pipe(
      tap(response => {
        console.log('Item deleted successfully!', response);
        this.itemAddedSource.next();
        this.itemDeletedSource.next();
      })
    );
  }

}
