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
  itemAdded$ = this.itemAddedSource.asObservable(); 
  constructor(private http: HttpClient) { }

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
}
